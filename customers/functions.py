from decimal import Decimal
from customers.models import Customer, PrivilegePointHistory, PrivilegePoint


def update_customer_credit_debit(pk, transaction_type, amount):
    if amount > 0:
        customer = Customer.objects.get(pk=pk)

        opening_type = customer.opening_type
        opening_balance = customer.opening_balance
        if opening_type == "credit":
            debit = 0
            credit = opening_balance
        elif opening_type == "debit":
            debit = 0
            credit = opening_balance

        customer_objects = Customer.objects.filter(pk=pk)

        if transaction_type == "credit":
            if debit > 0:
                debit_balance = debit - amount
                if debit_balance < 0:
                    abs_debit_balance = abs(debit_balance)
                    customer_objects.update(opening_balance=abs_debit_balance)
                else:
                    customer_objects.update(opening_balance=debit_balance)
            else:
                customer_objects.update(opening_balance=credit+amount)

        elif transaction_type == "debit":
            if credit > 0:
                credit_balance = credit - amount
                if credit_balance < 0:
                    abs_credit_balance = abs(credit_balance)
                    customer_objects.update( opening_balance=abs_credit_balance)
                else:
                    customer_objects.update(opening_balance=credit_balance)
            else:
                customer_objects.update(opening_balance=debit+amount)


def update_privilege_point(customer, point_type, used_point=0, sale_instance=None, order_instance=None):
    point_instances = PrivilegePoint.objects.filter(is_deleted=False)
    gained_point = 0

    if point_instances.exists() and any([sale_instance, order_instance]):
        privilege_point_instance = point_instances.first()

        # Adding Privilege Point to customer
        if point_type == 'gained':
            print("inside gained")
            minimum_amount = privilege_point_instance.minimum_amount

            if sale_instance and sale_instance.total >= minimum_amount:
                gained_point = (sale_instance.total // minimum_amount) * privilege_point_instance.point_gained_offline
                title = f"Points gained from Purchase: {sale_instance.sale_id}"

            elif order_instance and order_instance.total_amt >= minimum_amount:
                gained_point = (Decimal(order_instance.total_amt) // minimum_amount) * privilege_point_instance.point_gained_online
                title = f"Points gained from Order: {order_instance.order_id}"

            if gained_point > 0:
                gained_amount = gained_point * privilege_point_instance.value_of_point
                customer.privilege_points += gained_point
                customer.current_privilege_points += gained_point
                customer.save()

                PrivilegePointHistory.objects.create(
                    customer = customer,
                    title = title,
                    point_type = 10,
                    points = gained_point,
                    value_in_amount = gained_amount
                )

                return gained_point, gained_amount

        # Using Privilege Point of customer
        elif point_type == 'used' and used_point > 0:
            print("this loop")
            if sale_instance:
                title = f"Points used in Purchase: {sale_instance.sale_id}"
            elif order_instance:
                title = f"Points used in Order: {order_instance.order_id}"

            used_amount = used_point * privilege_point_instance.value_of_point

            customer.current_privilege_points -= used_point
            customer.save()

            PrivilegePointHistory.objects.create(
                customer = customer,
                title = title,
                point_type = 20,
                points = used_point,
                value_in_amount = used_amount
            )

            return True, used_amount
    return False, 0
