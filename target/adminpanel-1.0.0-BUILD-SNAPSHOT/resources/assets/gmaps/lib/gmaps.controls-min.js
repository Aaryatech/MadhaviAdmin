GMaps.prototype.createControl=function(a){var d=document.createElement("div");d.style.cursor="pointer";d.style.fontFamily="Arial, sans-serif";d.style.fontSize="13px";d.style.boxShadow="rgba(0, 0, 0, 0.398438) 0px 2px 4px";for(var b in a.style){d.style[b]=a.style[b]}if(a.id){d.id=a.id}if(a.classes){d.className=a.classes}if(a.content){d.innerHTML=a.content}for(var c in a.events){(function(f,e){google.maps.event.addDomListener(f,e,function(){a.events[e].apply(this,[this])})})(d,c)}d.index=1;return d};GMaps.prototype.addControl=function(b){var a=google.maps.ControlPosition[b.position.toUpperCase()];delete b.position;var c=this.createControl(b);this.controls.push(c);this.map.controls[a].push(c);return c};