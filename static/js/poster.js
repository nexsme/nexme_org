// static/poster/editor.js
(function(){
  const $ = (sel)=>document.querySelector(sel);
  const $$ = (sel)=>document.querySelectorAll(sel);

  // Canvas
  const canvas = new fabric.Canvas('c', {
    preserveObjectStacking: true,
    selection: true
  });

  // Snap toggle
  let snapping = false;
  const SNAP = 10;
  const snapBtn = $('#snap');
  snapBtn.addEventListener('click', ()=>{ snapping = !snapping; snapBtn.classList.toggle('on', snapping); });

  // History
  const state = { undo: [], redo: [] };
  function saveState() {
    state.undo.push(JSON.stringify(canvas));
    state.redo.length = 0;
  }
  canvas.on('object:added', saveState);
  canvas.on('object:modified', saveState);
  canvas.on('object:removed', saveState);

  $('#undo').addEventListener('click', ()=>{
    if(!state.undo.length) return;
    state.redo.push(JSON.stringify(canvas));
    const prev = state.undo.pop();
    canvas.loadFromJSON(prev, ()=>{ canvas.renderAll(); });
  });
  $('#redo').addEventListener('click', ()=>{
    if(!state.redo.length) return;
    state.undo.push(JSON.stringify(canvas));
    const next = state.redo.pop();
    canvas.loadFromJSON(next, ()=>{ canvas.renderAll(); });
  });

  // Mouse placement hint: place newly added text at cursor
  let lastPointer = { x: 60, y: 60 };
  canvas.on('mouse:move', (opt)=>{
    const p = canvas.getPointer(opt.e);
    lastPointer = p;
  });

  // Snap to edges
  canvas.on('object:moving', function(opt){
    if(!snapping) return;
    const obj = opt.target;
    const left = obj.left, top = obj.top, w = obj.width * obj.scaleX, h = obj.height * obj.scaleY;
    // Snap to canvas edges
    if(Math.abs(left) < SNAP) obj.left = 0;
    if(Math.abs(top) < SNAP) obj.top = 0;
    if(Math.abs((canvas.width - (left+w))) < SNAP) obj.left = canvas.width - w;
    if(Math.abs((canvas.height - (top+h))) < SNAP) obj.top = canvas.height - h;
  });

  // Helpers
  function activeText(){
    const obj = canvas.getActiveObject();
    return obj && obj.type === 'i-text' ? obj : null;
  }

  // Add elements
  $('#addText').addEventListener('click', ()=>{
    const t = new fabric.IText('Double-click to edit', {
      left: lastPointer.x, top: lastPointer.y,
      fill: $('#fillColor').value, fontSize: parseInt($('#fontSize').value,10) || 36,
      fontFamily: $('#fontFamily').value, lineHeight: parseFloat($('#lineHeight').value) || 1.2,
      charSpacing: parseInt($('#charSpacing').value,10) || 0,
      editable: true,
    });
    canvas.add(t).setActiveObject(t);
  });

  $('#addRect').addEventListener('click', ()=>{
    const r = new fabric.Rect({ left: 80, top: 80, width: 220, height: 140, fill: '#eeeeee' });
    canvas.add(r).setActiveObject(r);
  });

  $('#addCircle').addEventListener('click', ()=>{
    const c = new fabric.Circle({ left: 100, top: 100, radius: 80, fill: '#dddddd' });
    canvas.add(c).setActiveObject(c);
  });

  $('#imgUpload').addEventListener('change', (e)=>{
    const file = e.target.files[0];
    if(!file) return;
    const reader = new FileReader();
    reader.onload = function(f){
      fabric.Image.fromURL(f.target.result, (img)=>{
        img.set({ left: 100, top: 100, selectable: true });
        // Fit large images
        const maxW = canvas.width * 0.9, maxH = canvas.height * 0.9;
        const scale = Math.min(maxW / img.width, maxH / img.height, 1);
        img.scale(scale);
        canvas.add(img).setActiveObject(img);
      });
    };
    reader.readAsDataURL(file);
    e.target.value = '';
  });

  // Arrange
  $('#bringForward').addEventListener('click', ()=>{ const o = canvas.getActiveObject(); if(o) canvas.bringForward(o); });
  $('#sendBack').addEventListener('click', ()=>{ const o = canvas.getActiveObject(); if(o) canvas.sendBackwards(o); });
  $('#lock').addEventListener('click', ()=>{
    const o = canvas.getActiveObject(); if(!o) return;
    const locked = !o.lockMovementX;
    o.set({ lockMovementX: locked, lockMovementY: locked, lockScalingX: locked, lockScalingY: locked, lockRotation: locked, hasControls: !locked, selectable: !locked });
    canvas.discardActiveObject();
    canvas.renderAll();
  });
  $('#clone').addEventListener('click', ()=>{
    const o = canvas.getActiveObject(); if(!o) return;
    o.clone((cloned)=>{
      cloned.set({ left: o.left + 20, top: o.top + 20 });
      canvas.add(cloned).setActiveObject(cloned);
    });
  });
  $('#delete').addEventListener('click', ()=>{ const o = canvas.getActiveObjects(); if(!o.length) return; o.forEach(ob=>canvas.remove(ob)); canvas.discardActiveObject(); canvas.requestRenderAll(); });

  // Canvas controls
  const presets = {
    "1080x1350":[1080,1350],
    "1080x1080":[1080,1080],
    "1920x1080":[1920,1080],
    "2480x3508":[2480,3508],
  };
  function resizeCanvas(w,h){
    canvas.setWidth(w); canvas.setHeight(h);
    canvas.renderAll();
  }
  $('#preset').addEventListener('change', (e)=>{
    const [w,h] = presets[e.target.value];
    resizeCanvas(w,h);
  });
  $('#bgColor').addEventListener('input', (e)=>{
    canvas.setBackgroundColor(e.target.value, canvas.renderAll.bind(canvas));
  });
  $('#clearCanvas').addEventListener('click', ()=>{
    if(confirm('Clear all items?')) { canvas.clear(); canvas.setBackgroundColor($('#bgColor').value || '#ffffff', canvas.renderAll.bind(canvas)); }
  });

  // Text toolbar
  function applyToText(fn){
    const t = activeText(); if(!t) return;
    fn(t);
    canvas.requestRenderAll();
  }
  $('#fontFamily').addEventListener('change', (e)=> applyToText(t=> t.set({ fontFamily: e.target.value })));
  $('#fontSize').addEventListener('change', (e)=> applyToText(t=> t.set({ fontSize: parseInt(e.target.value,10)||36 })));
  $('#fillColor').addEventListener('change', (e)=> applyToText(t=> t.set({ fill: e.target.value })));
  $('#lineHeight').addEventListener('change', (e)=> applyToText(t=> t.set({ lineHeight: parseFloat(e.target.value)||1.2 })));
  $('#charSpacing').addEventListener('change', (e)=> applyToText(t=> t.set({ charSpacing: parseInt(e.target.value,10)||0 })));
  $('#bold').addEventListener('click', ()=> applyToText(t=> t.set({ fontWeight: t.fontWeight === 'bold' ? 'normal' : 'bold' })));
  $('#italic').addEventListener('click', ()=> applyToText(t=> t.set({ fontStyle: t.fontStyle === 'italic' ? 'normal' : 'italic' })));
  $('#underline').addEventListener('click', ()=> applyToText(t=> t.set({ underline: !t.underline })));
  $('#alignLeft').addEventListener('click', ()=> applyToText(t=> t.set({ textAlign: 'left' })));
  $('#alignCenter').addEventListener('click', ()=> applyToText(t=> t.set({ textAlign: 'center' })));
  $('#alignRight').addEventListener('click', ()=> applyToText(t=> t.set({ textAlign: 'right' })));

  // Keyboard delete & nudging
  document.addEventListener('keydown', (e)=>{
    const obj = canvas.getActiveObject();
    if(!obj) return;
    if(e.key === 'Delete' || e.key === 'Backspace'){ canvas.remove(obj); canvas.discardActiveObject(); canvas.requestRenderAll(); }
    const step = e.shiftKey ? 10 : 1;
    if(['ArrowUp','ArrowDown','ArrowLeft','ArrowRight'].includes(e.key)){
      e.preventDefault();
      const d = { ArrowUp:[0,-step], ArrowDown:[0,step], ArrowLeft:[-step,0], ArrowRight:[step,0] }[e.key];
      obj.left += d[0]; obj.top += d[1];
      obj.setCoords(); canvas.requestRenderAll();
    }
  });

  // Export helpers
  function downloadDataUrl(dataUrl, filename){
    const a = document.createElement('a');
    a.href = dataUrl; a.download = filename;
    document.body.appendChild(a); a.click(); a.remove();
  }
  $('#exportPNG').addEventListener('click', ()=>{
    const data = canvas.toDataURL({ format:'png', quality:1.0, enableRetinaScaling:true });
    downloadDataUrl(data, (document.querySelector('#title').value || 'poster') + '.png');
  });
  $('#exportJPG').addEventListener('click', ()=>{
    const data = canvas.toDataURL({ format:'jpeg', quality:1.0, enableRetinaScaling:true });
    downloadDataUrl(data, (document.querySelector('#title').value || 'poster') + '.jpg');
  });
  $('#exportPDF').addEventListener('click', ()=>{
    const { jsPDF } = window.jspdf;
    const pdf = new jsPDF({ orientation: canvas.width > canvas.height ? 'l' : 'p', unit:'pt', format: [canvas.width, canvas.height] });
    const imgData = canvas.toDataURL({ format:'png', quality:1 });
    pdf.addImage(imgData, 'PNG', 0, 0, canvas.width, canvas.height);
    pdf.save((document.querySelector('#title').value || 'poster') + '.pdf');
  });

  // CSRF
  function getCookie(name){
    const v = `; ${document.cookie}`.match(`;\\s*${name}=([^;]+)`);
    return v ? v[1] : null;
  }

  // Save to server
  $('#saveServer').addEventListener('click', async ()=>{
    const title = $('#title').value || 'Untitled';
    const canvasJson = JSON.stringify(canvas);
    const png = canvas.toDataURL({ format:'png', quality:1 });
    const posterId = (window.__INITIAL_POSTER__ && window.__INITIAL_POSTER__.id) || '';

    const form = new FormData();
    form.append('title', title);
    form.append('canvas_json', canvasJson);
    form.append('image_data', png);
    form.append('width', canvas.width);
    form.append('height', canvas.height);
    if(posterId) form.append('poster_id', posterId);

    const res = await fetch('/save/', {
      method: 'POST',
      body: form,
      headers: {'X-CSRFToken': getCookie('csrftoken') || ''},
    });
    const data = await res.json();
    if(data.ok){
      alert('Saved!');
      window.__INITIAL_POSTER__ = window.__INITIAL_POSTER__ || {};
      window.__INITIAL_POSTER__.id = data.id;
      history.replaceState(null, '', '?id=' + data.id);
    } else {
      alert('Save failed');
    }
  });

  // New canvas
  $('#newCanvas').addEventListener('click', ()=>{
    if(!confirm('Start a new canvas? Unsaved changes will be lost.')) return;
    canvas.clear();
    canvas.setBackgroundColor('#ffffff', ()=>canvas.renderAll());
    $('#title').value = 'Untitled';
    window.__INITIAL_POSTER__ = { id: null };
  });

  // Load existing poster if provided
  if(window.__INITIAL_POSTER__ && window.__INITIAL_POSTER__.id){
    try{
      const p = window.__INITIAL_POSTER__;
      if(p.width && p.height) resizeCanvas(p.width, p.height);
      if(p.canvas_json){
        canvas.loadFromJSON(p.canvas_json, ()=>{ canvas.renderAll(); });
      }
      if(p.title && p.title !== 'null') $('#title').value = p.title;
    }catch(err){ console.error('Failed to load poster', err); }
  }else{
    // Default bg
    canvas.setBackgroundColor('#ffffff', canvas.renderAll.bind(canvas));
  }
})();
