(function(b){var a={series:{fillBetween:null}};function c(f){function d(j,h){var g;for(g=0;g<h.length;++g){if(h[g].id===j.fillBetween){return h[g]}}if(typeof j.fillBetween==="number"){if(j.fillBetween<0||j.fillBetween>=h.length){return null}return h[j.fillBetween]}return null}function e(C,u,g){if(u.fillBetween==null){return}var p=d(u,C.getData());if(!p){return}var z=g.pointsize,F=g.points,h=p.datapoints.pointsize,x=p.datapoints.points,r=[],w,v,k,H,G,q,t=u.lines.show,o=z>2&&g.format[2].y,n=t&&u.lines.steps,E=true,D=0,B=0,A,y;while(true){if(D>=F.length){break}A=r.length;if(F[D]==null){for(y=0;y<z;++y){r.push(F[D+y])}D+=z}else{if(B>=x.length){if(!t){for(y=0;y<z;++y){r.push(F[D+y])}}D+=z}else{if(x[B]==null){for(y=0;y<z;++y){r.push(null)}E=true;B+=h}else{w=F[D];v=F[D+1];H=x[B];G=x[B+1];q=0;if(w===H){for(y=0;y<z;++y){r.push(F[D+y])}q=G;D+=z;B+=h}else{if(w>H){if(t&&D>0&&F[D-z]!=null){k=v+(F[D-z+1]-v)*(H-w)/(F[D-z]-w);r.push(H);r.push(k);for(y=2;y<z;++y){r.push(F[D+y])}q=G}B+=h}else{if(E&&t){D+=z;continue}for(y=0;y<z;++y){r.push(F[D+y])}if(t&&B>0&&x[B-h]!=null){q=G+(x[B-h+1]-G)*(w-H)/(x[B-h]-H)}D+=z}}E=false;if(A!==r.length&&o){r[A+2]=q}}}}if(n&&A!==r.length&&A>0&&r[A]!==null&&r[A]!==r[A-z]&&r[A+1]!==r[A-z+1]){for(y=0;y<z;++y){r[A+z+y]=r[A+y]}r[A+1]=r[A-z+1]}}g.points=r}f.hooks.processDatapoints.push(e)}b.plot.plugins.push({init:c,options:a,name:"fillbetween",version:"1.0"})})(jQuery);