qx.$$packageData['512']={"locales":{},"resources":{"qxc/application/datademo/identica.png":[200,150,"png","qxc.application.datademo"],"qxc/application/datademo/service.js":"qxc.application.datademo"},"translations":{"C":{},"cs":{},"de":{},"de_AT":{},"de_DE":{},"en":{},"en_GB":{},"en_US":{},"es":{},"es_ES":{},"es_MX":{},"pt":{},"ro":{},"ro_RO":{},"sv":{},"sv_SE":{}}};
qx.Part.$$notifyLoad("512", function() {
(function(){var a="loadEnd",b="qx.io.request.AbstractRequest",c="changePhase",d="GET",f="sent",g="qx.event.type.Data",h="qx.io.request.authentication.IAuthentication",i="error",j="fail",k="loading",l="load",m="qx.event.type.Event",n="abort",o="success",p="String",q="",r="opened",s="POST",t="statusError",u="readyStateChange",v="Abstract method call",w="abstract",x="unsent",y="changeResponse",z="Number",A="Content-Type",B="timeout",C="undefined";qx.Class.define(b,{type:w,extend:qx.core.Object,construct:function(D){qx.core.Object.call(this);if(D!==undefined){this.setUrl(D);};this.__rC={};var E=this._transport=this._createTransport();this._setPhase(x);this.__tH=qx.lang.Function.bind(this._onReadyStateChange,this);this.__tI=qx.lang.Function.bind(this._onLoad,this);this.__tJ=qx.lang.Function.bind(this._onLoadEnd,this);this.__tK=qx.lang.Function.bind(this._onAbort,this);this.__tL=qx.lang.Function.bind(this._onTimeout,this);this.__tM=qx.lang.Function.bind(this._onError,this);E.onreadystatechange=this.__tH;E.onload=this.__tI;E.onloadend=this.__tJ;E.onabort=this.__tK;E.ontimeout=this.__tL;E.onerror=this.__tM;},events:{"readyStateChange":m,"success":m,"load":m,"loadEnd":m,"abort":m,"timeout":m,"error":m,"statusError":m,"fail":m,"changeResponse":g,"changePhase":g},properties:{url:{check:p},timeout:{check:z,nullable:true,init:0},requestData:{check:function(F){return qx.lang.Type.isString(F)||qx.Class.isSubClassOf(F.constructor,qx.core.Object)||qx.lang.Type.isObject(F);},nullable:true},authentication:{check:h,nullable:true}},members:{__tH:null,__tI:null,__tJ:null,__tK:null,__tL:null,__tM:null,__tN:null,__tO:null,__tP:null,__rC:null,__tQ:null,_transport:null,_createTransport:function(){throw new Error(v);},_getConfiguredUrl:function(){},_getConfiguredRequestHeaders:function(){},_getParsedResponse:function(){throw new Error(v);},_getMethod:function(){return d;},_isAsync:function(){return true;},send:function(){var K=this._transport,G,J,H,I;G=this._getConfiguredUrl();if(/\#/.test(G)){G=G.replace(/\#.*/,q);};K.timeout=this.getTimeout();J=this._getMethod();H=this._isAsync();{};K.open(J,G,H);this._setPhase(r);I=this._serializeData(this.getRequestData());this._setRequestHeaders();{};J==d?K.send():K.send(I);this._setPhase(f);},abort:function(){{};this.__tO=true;this.__tP=n;this._transport.abort();},_setRequestHeaders:function(){var M=this._transport,L=this._getAllRequestHeaders();for(var N in L){M.setRequestHeader(N,L[N]);};},_getAllRequestHeaders:function(){var O={};qx.lang.Object.mergeWith(O,this._getConfiguredRequestHeaders());qx.lang.Object.mergeWith(O,this.__tR());qx.lang.Object.mergeWith(O,this.__tQ);qx.lang.Object.mergeWith(O,this.__rC);return O;},__tR:function(){var Q=this.getAuthentication(),P={};if(Q){Q.getAuthHeaders().forEach(function(R){P[R.key]=R.value;});return P;};},setRequestHeader:function(S,T){this.__rC[S]=T;},getRequestHeader:function(U){return this.__rC[U];},removeRequestHeader:function(V){if(this.__rC[V]){delete this.__rC[V];};},getTransport:function(){return this._transport;},getReadyState:function(){return this._transport.readyState;},getPhase:function(){return this.__tP;},getStatus:function(){return this._transport.status;},getStatusText:function(){return this._transport.statusText;},getResponseText:function(){return this._transport.responseText;},getAllResponseHeaders:function(){return this._transport.getAllResponseHeaders();},getResponseHeader:function(W){return this._transport.getResponseHeader(W);},overrideResponseContentType:function(X){return this._transport.overrideMimeType(X);},getResponseContentType:function(){return this.getResponseHeader(A);},isDone:function(){return this.getReadyState()===4;},getResponse:function(){return this.__tN;},_setResponse:function(ba){var Y=ba;if(this.__tN!==ba){this.__tN=ba;this.fireEvent(y,qx.event.type.Data,[this.__tN,Y]);};},_onReadyStateChange:function(){var bb=this.getReadyState();{};this.fireEvent(u);if(this.__tO){return;};if(bb===3){this._setPhase(k);};if(this.isDone()){this.__tS();};},__tS:function(){{};this._setPhase(l);if(qx.util.Request.isSuccessful(this.getStatus())){{};this._setResponse(this._getParsedResponse());this._fireStatefulEvent(o);}else {try{this._setResponse(this._getParsedResponse());}catch(e){};if(this.getStatus()!==0){this._fireStatefulEvent(t);this.fireEvent(j);};};},_onLoad:function(){this.fireEvent(l);},_onLoadEnd:function(){this.fireEvent(a);},_onAbort:function(){this._fireStatefulEvent(n);},_onTimeout:function(){this._fireStatefulEvent(B);this.fireEvent(j);},_onError:function(){this.fireEvent(i);this.fireEvent(j);},_fireStatefulEvent:function(bc){{};this._setPhase(bc);this.fireEvent(bc);},_setPhase:function(bd){var be=this.__tP;{};this.__tP=bd;this.fireDataEvent(c,bd,be);},_serializeData:function(bh){var bf=typeof this.getMethod!==C&&this.getMethod()==s,bg=/application\/.*\+?json/.test(this.getRequestHeader(A));if(!bh){return null;};if(qx.lang.Type.isString(bh)){return bh;};if(qx.Class.isSubClassOf(bh.constructor,qx.core.Object)){return qx.util.Serializer.toUriParameter(bh);};if(bg&&(qx.lang.Type.isObject(bh)||qx.lang.Type.isArray(bh))){return qx.lang.Json.stringify(bh);};if(qx.lang.Type.isObject(bh)){return qx.util.Uri.toParameter(bh,bf);};}},environment:{"qx.debug.io":false},destruct:function(){var bj=this._transport,bi=function(){};if(this._transport){bj.onreadystatechange=bj.onload=bj.onloadend=bj.onabort=bj.ontimeout=bj.onerror=bi;bj.dispose();};}});})();(function(){var a="HEAD",b="CONNECT",c="OPTIONS",d="PUT",e="GET",f="PATCH",g="//",h="DELETE",i="POST",j="TRACE",k="qx.util.Request";qx.Bootstrap.define(k,{statics:{isCrossDomain:function(l){var n=qx.util.Uri.parseUri(l),location=window.location;if(!location){return false;};var m=location.protocol;if(!(l.indexOf(g)!==-1)){return false;};if(m.substr(0,m.length-1)==n.protocol&&location.host===n.host&&location.port===n.port){return false;};return true;},isSuccessful:function(status){return (status>=200&&status<300||status===304);},isMethod:function(p){var o=[e,i,d,h,a,c,j,b,f];return (o.indexOf(p)!==-1)?true:false;},methodAllowsRequestBody:function(q){return !((/^(GET|HEAD)$/).test(q));}}});})();(function(){var a="changeModel",b="application/json",c="json",d="aborted",e="__rS",f="loaded",g="qx.event.type.Data",h="error",i="fail",j="receiving",k="queued",l="changeState",m="success",n="String",o="changePhase",p="sending",q="_marshaler",r="completed",s="failed",t="qx.data.store.Json",u="configured",v="changeUrl",w="timeout",x="_applyUrl";qx.Class.define(t,{extend:qx.core.Object,construct:function(y,z){qx.core.Object.call(this);this._marshaler=new qx.data.marshal.Json(z);this._delegate=z;if(y!=null){this.setUrl(y);};},events:{"loaded":g,"error":g},properties:{model:{nullable:true,event:a},state:{check:[u,k,p,j,r,d,w,s],init:u,event:l},url:{check:n,apply:x,event:v,nullable:true}},members:{_marshaler:null,_delegate:null,__rS:null,_applyUrl:function(B,A){if(B!=null){B=qx.util.AliasManager.getInstance().resolve(B);B=qx.util.ResourceManager.getInstance().toUri(B);this._createRequest(B);};},_getRequest:function(){return this.__rS;},_setRequest:function(C){this.__rS=C;},_createRequest:function(D){if(this.__rS){this.__rS.dispose();this.__rS=null;};var E=new qx.io.request.Xhr(D);this._setRequest(E);E.setAccept(b);E.setParser(c);E.addListener(m,this._onSuccess,this);var F=this._delegate;if(F&&qx.lang.Type.isFunction(F.configureRequest)){this._delegate.configureRequest(E);};E.addListener(o,this._onChangePhase,this);E.addListener(i,this._onFail,this);E.send();},_onChangePhase:function(I){var G=I.getData(),J={},H;J={"opened":u,"sent":p,"loading":j,"success":r,"abort":d,"timeout":w,"statusError":s};H=J[G];if(H){this.setState(H);};},_onFail:function(K){var L=K.getTarget();this.fireDataEvent(h,L);},_onSuccess:function(Q){if(this.isDisposed()){return;};var N=Q.getTarget(),M=N.getResponse();var O=this._delegate;if(O&&qx.lang.Type.isFunction(O.manipulateData)){M=this._delegate.manipulateData(M);};this._marshaler.toClass(M,true);var P=this.getModel();this.setModel(this._marshaler.toModel(M));if(P&&P.dispose){P.dispose();};this.fireDataEvent(f,this.getModel());if(this.__rS){this.__rS.dispose();this.__rS=null;};},reload:function(){var R=this.getUrl();if(R!=null){this._createRequest(R);};}},destruct:function(){if(this.__rS!=null){this._disposeObjects(e);};this._disposeSingletonObjects(q);this._delegate=null;}});})();(function(){var a="callback",b="changePhase",c="fail",d="success",e="qx.data.store.Jsonp",f="String";qx.Class.define(e,{extend:qx.data.store.Json,construct:function(g,h,i){if(i!=undefined){this.setCallbackParam(i);};qx.data.store.Json.call(this,g,h);},properties:{callbackParam:{check:f,init:a,nullable:true},callbackName:{check:f,nullable:true}},members:{_createRequest:function(j){if(this._getRequest()){this._getRequest().dispose();};var k=new qx.io.request.Jsonp();this._setRequest(k);k.setCallbackParam(this.getCallbackParam());k.setCallbackName(this.getCallbackName());k.setUrl(j);k.addListener(d,this._onSuccess,this);var l=this._delegate;if(l&&qx.lang.Type.isFunction(l.configureRequest)){this._delegate.configureRequest(k);};k.addListener(b,this._onChangePhase,this);k.addListener(c,this._onFail,this);k.send();}}});})();(function(){var a="null",b="XMLHttpRequest",c="Boolean",d="X-Requested-With",e="",f="application/x-www-form-urlencoded",g="Cache-Control",h="Content-Type",i="qx.event.type.Event",j="GET",k="qx.io.request.Xhr",l="Accept",m="String";qx.Class.define(k,{extend:qx.io.request.AbstractRequest,construct:function(n,o){if(o!==undefined){this.setMethod(o);};qx.io.request.AbstractRequest.call(this,n);this._parser=this._createResponseParser();},events:{"readyStateChange":i,"success":i,"load":i,"statusError":i},properties:{method:{init:j},async:{check:c,init:true},accept:{check:m,nullable:true},cache:{check:function(p){return qx.lang.Type.isBoolean(p)||qx.lang.Type.isString(p);},init:true}},members:{_parser:null,_createTransport:function(){return new qx.bom.request.Xhr();},_getConfiguredUrl:function(){var q=this.getUrl(),r;if(this.getMethod()===j&&this.getRequestData()){r=this._serializeData(this.getRequestData());q=qx.util.Uri.appendParamsToUrl(q,r);};if(this.getCache()===false){q=qx.util.Uri.appendParamsToUrl(q,{nocache:new Date().valueOf()});};return q;},_getConfiguredRequestHeaders:function(){var s={},t=qx.util.Request.methodAllowsRequestBody(this.getMethod());if(!qx.util.Request.isCrossDomain(this.getUrl())){s[d]=b;};if(qx.lang.Type.isString(this.getCache())){s[g]=this.getCache();};if(this.getRequestData()!==a&&t){s[h]=f;};if(this.getAccept()){{};s[l]=this.getAccept();};return s;},_getMethod:function(){return this.getMethod();},_isAsync:function(){return this.isAsync();},_createResponseParser:function(){return new qx.util.ResponseParser();},_getParsedResponse:function(){var v=this._transport.responseText,u=this.getResponseContentType()||e;return this._parser.parse(v,u);},setParser:function(w){return this._parser.setParser(w);}}});})();(function(){var a="qx.bom.request.Jsonp",b="callback",c="open",d="dispose",e="",f="_onNativeLoad",g="qx",h=".callback",i="qx.bom.request.Jsonp.";qx.Bootstrap.define(a,{extend:qx.bom.request.Script,construct:function(){qx.bom.request.Script.apply(this);this.__uA();},members:{responseJson:null,__ci:null,__ut:null,__uu:null,__uv:null,__uw:null,__ux:null,__ug:null,__uy:e,open:function(o,k){if(this.__ug){return;};var m={},l,n,j=this;this.responseJson=null;this.__uv=false;l=this.__ut||b;n=this.__uu||this.__uy+i+this.__ci+h;if(!this.__uu){this.constructor[this.__ci]=this;}else {if(!window[this.__uu]){this.__uw=true;window[this.__uu]=function(p){j.callback(p);};}else {{};};};{};m[l]=n;this.__ux=k=qx.util.Uri.appendParamsToUrl(k,m);this.__gw(c,[o,k]);},callback:function(q){if(this.__ug){return;};this.__uv=true;{};this.responseJson=q;this.constructor[this.__ci]=undefined;this.__uz();},setCallbackParam:function(r){this.__ut=r;return this;},setCallbackName:function(name){this.__uu=name;return this;},setPrefix:function(s){this.__uy=s;},getGeneratedUrl:function(){return this.__ux;},dispose:function(){this.__uz();this.__gw(d);},_onNativeLoad:function(){this.status=this.__uv?200:500;this.__gw(f);},__uz:function(){if(this.__uw&&window[this.__uu]){window[this.__uu]=undefined;this.__uw=false;};},__gw:function(u,t){qx.bom.request.Script.prototype[u].apply(this,t||[]);},__uA:function(){this.__ci=g+(new Date().valueOf())+(e+Math.random()).substring(2,5);}}});})();(function(){var a="showcase.page.databinding.Content";qx.Class.define(a,{extend:showcase.AbstractContent,construct:function(b){showcase.AbstractContent.call(this,b);this.setView(new qxc.application.datademo.Demo());}});})();(function(){var a="activex",b="No XHR support available.",c="If-None-Match",d="xhr",f="If-Modified-Since",g="engine.version",h="onunload",i="GET",j="-1",k="qx.debug.io",l="error",m="loadend",n="load",o="abort",p="browser.documentmode",q="",r="engine.name",s="Microsoft.XMLHTTP",t="Already disposed",u="browser.version",v="opera",w="qx.bom.request.Xhr",x="Not enough arguments",y="gecko",z="If-Match",A="mshtml",B="readystatechange",C="Microsoft.XMLDOM",D="file:",E="If-Range",F="Content-Type",G="io.xhr",H="on",I="timeout",J="undefined",K="Native XHR object doesn't support overrideMimeType.";qx.Bootstrap.define(w,{extend:Object,construct:function(){var L=qx.Bootstrap.bind(this.__uj,this);if(qx.event&&qx.event.GlobalError&&qx.event.GlobalError.observeMethod){this.__tV=qx.event.GlobalError.observeMethod(L);}else {this.__tV=L;};this.__tW=qx.Bootstrap.bind(this.__ui,this);this.__tL=qx.Bootstrap.bind(this.__un,this);this.__uh();this._emitter=new qx.event.Emitter();if(window.attachEvent){this.__tX=qx.Bootstrap.bind(this.__uq,this);window.attachEvent(h,this.__tX);};},statics:{UNSENT:0,OPENED:1,HEADERS_RECEIVED:2,LOADING:3,DONE:4},events:{"readystatechange":w,"error":w,"loadend":w,"timeout":w,"abort":w,"load":w},members:{readyState:0,responseText:q,responseXML:null,status:0,statusText:q,timeout:0,open:function(Q,M,N,P,O){this.__us();if(typeof M===J){throw new Error(x);}else if(typeof Q===J){Q=i;};this.__tO=false;this.__tY=false;this.__ua=false;this.__ub=M;if(typeof N==J){N=true;};this.__uc=N;if(!this.__ur()&&this.readyState>qx.bom.request.Xhr.UNSENT){this.dispose();this.__uh();};this.__ue.onreadystatechange=this.__tV;try{{};this.__ue.open(Q,M,N,P,O);}catch(R){if(!qx.util.Request.isCrossDomain(M)){throw R;};if(!this.__uc){this.__ud=R;};if(this.__uc){if(window.XDomainRequest){this.readyState=4;this.__ue=new XDomainRequest();this.__ue.onerror=qx.Bootstrap.bind(function(){this._emit(B);this._emit(l);this._emit(m);},this);{};this.__ue.open(Q,M,N,P,O);return;};window.setTimeout(qx.Bootstrap.bind(function(){if(this.__ug){return;};this.readyState=4;this._emit(B);this._emit(l);this._emit(m);},this));};};if(qx.core.Environment.get(r)===A&&qx.core.Environment.get(p)<9&&this.__ue.readyState>0){this.__ue.setRequestHeader(f,j);};if(qx.core.Environment.get(r)===y&&parseInt(qx.core.Environment.get(g),10)<2&&!this.__uc){this.readyState=qx.bom.request.Xhr.OPENED;this._emit(B);};},setRequestHeader:function(S,T){this.__us();if(S==z||S==f||S==c||S==E){this.__ua=true;};this.__ue.setRequestHeader(S,T);return this;},send:function(U){this.__us();if(!this.__uc&&this.__ud){throw this.__ud;};if(qx.core.Environment.get(r)===v&&this.timeout===0){this.timeout=10000;};if(this.timeout>0){this.__uf=window.setTimeout(this.__tL,this.timeout);};U=typeof U==J?null:U;try{{};this.__ue.send(U);}catch(W){if(!this.__uc){throw W;};if(this._getProtocol()===D){this.readyState=2;this.__uk();var V=this;window.setTimeout(function(){if(V.__ug){return;};V.readyState=3;V.__uk();V.readyState=4;V.__uk();});};};if(qx.core.Environment.get(r)===y&&!this.__uc){this.__uj();};this.__tY=true;return this;},abort:function(){this.__us();this.__tO=true;this.__ue.abort();if(this.__ue){this.readyState=this.__ue.readyState;};return this;},_emit:function(event){if(this[H+event]){this[H+event]();};this._emitter.emit(event,this);},onreadystatechange:function(){},onload:function(){},onloadend:function(){},onerror:function(){},onabort:function(){},ontimeout:function(){},on:function(name,X,Y){this._emitter.on(name,X,Y);return this;},getResponseHeader:function(ba){this.__us();return this.__ue.getResponseHeader(ba);},getAllResponseHeaders:function(){this.__us();return this.__ue.getAllResponseHeaders();},overrideMimeType:function(bb){this.__us();if(this.__ue.overrideMimeType){this.__ue.overrideMimeType(bb);}else {throw new Error(K);};return this;},getRequest:function(){return this.__ue;},dispose:function(){if(this.__ug){return false;};window.clearTimeout(this.__uf);if(window.detachEvent){window.detachEvent(h,this.__tX);};try{this.__ue.onreadystatechange;}catch(bd){return false;};var bc=function(){};this.__ue.onreadystatechange=bc;this.__ue.onload=bc;this.__ue.onerror=bc;this.abort();this.__ue=null;this.__ug=true;return true;},isDisposed:function(){return !!this.__ug;},_createNativeXhr:function(){var be=qx.core.Environment.get(G);if(be===d){return new XMLHttpRequest();};if(be==a){return new window.ActiveXObject(s);};qx.Bootstrap.error(this,b);},_getProtocol:function(){var bf=this.__ub;var bg=/^(\w+:)\/\//;if(bf!==null&&bf.match){var bh=bf.match(bg);if(bh&&bh[1]){return bh[1];};};return window.location.protocol;},__ue:null,__uc:null,__tV:null,__tW:null,__tX:null,__tL:null,__tY:null,__ub:null,__tO:null,__eP:null,__ug:null,__uf:null,__ud:null,__ua:null,__uh:function(){this.__ue=this._createNativeXhr();this.__ue.onreadystatechange=this.__tV;if(this.__ue.onabort){this.__ue.onabort=this.__tW;};this.__ug=this.__tY=this.__tO=false;},__ui:function(){if(!this.__tO){this.abort();};},__uj:function(){var bi=this.__ue,bj=true;{};if(this.readyState==bi.readyState){return;};this.readyState=bi.readyState;if(this.readyState===qx.bom.request.Xhr.DONE&&this.__tO&&!this.__tY){return;};if(!this.__uc&&(bi.readyState==2||bi.readyState==3)){return;};this.status=0;this.statusText=this.responseText=q;this.responseXML=null;if(this.readyState>=qx.bom.request.Xhr.HEADERS_RECEIVED){try{this.status=bi.status;this.statusText=bi.statusText;this.responseText=bi.responseText;this.responseXML=bi.responseXML;}catch(bk){bj=false;};if(bj){this.__uo();this.__up();};};this.__uk();if(this.readyState==qx.bom.request.Xhr.DONE){if(bi){bi.onreadystatechange=function(){};};};},__uk:function(){var bl=this;if(this.readyState===qx.bom.request.Xhr.DONE){window.clearTimeout(this.__uf);};if(qx.core.Environment.get(r)==A&&qx.core.Environment.get(p)<8){if(this.__uc&&!this.__tY&&this.readyState>=qx.bom.request.Xhr.LOADING){if(this.readyState==qx.bom.request.Xhr.LOADING){return;};if(this.readyState==qx.bom.request.Xhr.DONE){window.setTimeout(function(){if(bl.__ug){return;};bl.readyState=3;bl._emit(B);bl.readyState=4;bl._emit(B);bl.__ul();});return;};};};this._emit(B);if(this.readyState===qx.bom.request.Xhr.DONE){this.__ul();};},__ul:function(){if(this.__eP){this._emit(I);if(qx.core.Environment.get(r)===v){this._emit(l);};this.__eP=false;}else {if(this.__tO){this._emit(o);}else {if(this.__um()){this._emit(l);}else {this._emit(n);};};};this._emit(m);},__um:function(){var bm;if(this._getProtocol()===D){bm=!this.responseText;}else {bm=!this.statusText;};return bm;},__un:function(){var bn=this.__ue;this.readyState=qx.bom.request.Xhr.DONE;this.__eP=true;bn.abort();this.responseText=q;this.responseXML=null;this.__uk();},__uo:function(){var bo=this.readyState===qx.bom.request.Xhr.DONE;if(this._getProtocol()===D&&this.status===0&&bo){if(!this.__um()){this.status=200;};};if(this.status===1223){this.status=204;};if(qx.core.Environment.get(r)===v){if(bo&&this.__ua&&!this.__tO&&this.status===0){this.status=304;};};},__up:function(){if(qx.core.Environment.get(r)==A&&(this.getResponseHeader(F)||q).match(/[^\/]+\/[^\+]+\+xml/)&&this.responseXML&&!this.responseXML.documentElement){var bp=new window.ActiveXObject(C);bp.async=false;bp.validateOnParse=false;bp.loadXML(this.responseText);this.responseXML=bp;};},__uq:function(){try{if(this){this.dispose();};}catch(e){};},__ur:function(){var name=qx.core.Environment.get(r);var bq=qx.core.Environment.get(u);return !(name==A&&bq<9||name==y&&bq<3.5);},__us:function(){if(this.__ug){throw new Error(t);};}},defer:function(){qx.core.Environment.add(k,false);}});})();(function(){var a="function",b="qx.util.ResponseParser",c="";qx.Bootstrap.define(b,{construct:function(d){if(d!==undefined){this.setParser(d);};},statics:{PARSER:{json:qx.lang.Json.parse,xml:qx.xml.Document.fromString}},members:{__tU:null,parse:function(g,f){var e=this._getParser(f);if(typeof e===a){if(g!==c){return e.call(this,g);};};return g;},setParser:function(h){if(typeof qx.util.ResponseParser.PARSER[h]===a){return this.__tU=qx.util.ResponseParser.PARSER[h];};{};return this.__tU=h;},_getParser:function(j){var i=this.__tU,l=c,k=c;if(i){return i;};l=j||c;k=l.replace(/;.*$/,c);if(/^application\/(\w|\.)*\+?json$/.test(k)){i=qx.util.ResponseParser.PARSER.json;};if(/^application\/xml$/.test(k)){i=qx.util.ResponseParser.PARSER.xml;};if(/[^\/]+\/[^\+]+\+xml$/.test(l)){i=qx.util.ResponseParser.PARSER.xml;};return i;}}});})();(function(){var a="qx.io.request.Jsonp",b="qx.event.type.Event",c="Boolean";qx.Class.define(a,{extend:qx.io.request.AbstractRequest,events:{"success":b,"load":b,"statusError":b},properties:{cache:{check:c,init:true}},members:{_createTransport:function(){return new qx.bom.request.Jsonp();},_getConfiguredUrl:function(){var d=this.getUrl(),e;if(this.getRequestData()){e=this._serializeData(this.getRequestData());d=qx.util.Uri.appendParamsToUrl(d,e);};if(!this.getCache()){d=qx.util.Uri.appendParamsToUrl(d,{nocache:new Date().valueOf()});};return d;},_getParsedResponse:function(){return this._transport.responseJson;},setCallbackParam:function(f){this._transport.setCallbackParam(f);},setCallbackName:function(name){this._transport.setCallbackName(name);}}});})();(function(){var a="qx.util.Serializer",b='\\\\',c='\\f',d='"',e="null",f='\\"',g="}",h="get",j="{",k='\\r',l="",m='\\t',n="]",o="Class",p="Interface",q="[",r="Mixin",s='":',t="&",u='\\b',v="=",w='\\n',x=",";qx.Class.define(a,{statics:{toUriParameter:function(z,C,y){var E=l;var B=qx.util.PropertyUtil.getAllProperties(z.constructor);for(var name in B){if(B[name].group!=undefined){continue;};var A=z[h+qx.lang.String.firstUp(name)]();if(qx.lang.Type.isArray(A)){var D=qx.data&&qx.data.IListData&&qx.Class.hasInterface(A&&A.constructor,qx.data.IListData);for(var i=0;i<A.length;i++ ){var F=D?A.getItem(i):A[i];E+=this.__tT(name,F,C);};}else if(qx.lang.Type.isDate(A)&&y!=null){E+=this.__tT(name,y.format(A),C);}else {E+=this.__tT(name,A,C);};};return E.substring(0,E.length-1);},__tT:function(name,I,G){if(I&&I.$$type==o){I=I.classname;};if(I&&(I.$$type==p||I.$$type==r)){I=I.name;};if(I instanceof qx.core.Object&&G!=null){var H=encodeURIComponent(G(I));if(H===undefined){var H=encodeURIComponent(I);};}else {var H=encodeURIComponent(I);};return encodeURIComponent(name)+v+H+t;},toNativeObject:function(L,N,K){var O;if(L==null){return null;};if(qx.data&&qx.data.IListData&&qx.Class.hasInterface(L.constructor,qx.data.IListData)){O=[];for(var i=0;i<L.getLength();i++ ){O.push(qx.util.Serializer.toNativeObject(L.getItem(i),N,K));};return O;};if(qx.lang.Type.isArray(L)){O=[];for(var i=0;i<L.length;i++ ){O.push(qx.util.Serializer.toNativeObject(L[i],N,K));};return O;};if(L.$$type==o){return L.classname;};if(L.$$type==p||L.$$type==r){return L.name;};if(L instanceof qx.core.Object){if(N!=null){var J=N(L);if(J!=undefined){return J;};};O={};var Q=qx.util.PropertyUtil.getAllProperties(L.constructor);for(var name in Q){if(Q[name].group!=undefined){continue;};var M=L[h+qx.lang.String.firstUp(name)]();O[name]=qx.util.Serializer.toNativeObject(M,N,K);};return O;};if(qx.lang.Type.isDate(L)&&K!=null){return K.format(L);};if(qx.locale&&qx.locale.LocalizedString&&L instanceof qx.locale.LocalizedString){return L.toString();};if(qx.lang.Type.isObject(L)){O={};for(var P in L){O[P]=qx.util.Serializer.toNativeObject(L[P],N,K);};return O;};return L;},toJson:function(T,V,S){var W=l;if(T==null){return e;};if(qx.data&&qx.data.IListData&&qx.Class.hasInterface(T.constructor,qx.data.IListData)){W+=q;for(var i=0;i<T.getLength();i++ ){W+=qx.util.Serializer.toJson(T.getItem(i),V,S)+x;};if(W!=q){W=W.substring(0,W.length-1);};return W+n;};if(qx.lang.Type.isArray(T)){W+=q;for(var i=0;i<T.length;i++ ){W+=qx.util.Serializer.toJson(T[i],V,S)+x;};if(W!=q){W=W.substring(0,W.length-1);};return W+n;};if(T.$$type==o){return d+T.classname+d;};if(T.$$type==p||T.$$type==r){return d+T.name+d;};if(T instanceof qx.core.Object){if(V!=null){var R=V(T);if(R!=undefined){return d+R+d;};};W+=j;var Y=qx.util.PropertyUtil.getAllProperties(T.constructor);for(var name in Y){if(Y[name].group!=undefined){continue;};var U=T[h+qx.lang.String.firstUp(name)]();W+=d+name+s+qx.util.Serializer.toJson(U,V,S)+x;};if(W!=j){W=W.substring(0,W.length-1);};return W+g;};if(qx.locale&&qx.locale.LocalizedString&&T instanceof qx.locale.LocalizedString){T=T.toString();};if(qx.lang.Type.isDate(T)&&S!=null){return d+S.format(T)+d;};if(qx.lang.Type.isObject(T)){W+=j;for(var X in T){W+=d+X+s+qx.util.Serializer.toJson(T[X],V,S)+x;};if(W!=j){W=W.substring(0,W.length-1);};return W+g;};if(qx.lang.Type.isString(T)){T=T.replace(/([\\])/g,b);T=T.replace(/(["])/g,f);T=T.replace(/([\r])/g,k);T=T.replace(/([\f])/g,c);T=T.replace(/([\n])/g,w);T=T.replace(/([\t])/g,m);T=T.replace(/([\b])/g,u);return d+T+d;};if(qx.lang.Type.isDate(T)||qx.lang.Type.isRegExp(T)){return d+T+d;};return T+l;}}});})();(function(){var a="text",b="qxc/application/datademo/identica.png",c="one",d="http",e="callback",f="error",g="selection[0]",h="icon",j="Location: ",k="value",l="Details",m="Name: ",n="source",o="... service unavailable!",p="</a>",q="' target='_blank'>",r="qxc.application.datademo.Demo",s="invalid",t="user.name",u="model",v="qxc/application/datademo/service.js",w="user.location",x="<a href='",y=" ",z="user.profile_image_url",A="Avatar: ",B="Message: ";qx.Class.define(r,{extend:qx.ui.container.Composite,construct:function(){qx.ui.container.Composite.call(this);this._createView();},members:{_createView:function(){this.setLayout(new qx.ui.layout.Canvas());var I=new qx.ui.basic.Image(b);this.add(I,{left:10,top:15});var E=new qx.ui.form.List();this.add(E,{left:10,top:175,bottom:5});E.set({selectionMode:c,width:300,maxHeight:400,height:300});var F=new qx.data.controller.List(null,E);F.setDelegate(this);F.setLabelPath(a);F.setIconPath(z);var C=v;var K=new qx.data.store.Jsonp();K.setCallbackName(e);K.setUrl(C);K.bind(u,F,u);var H=new qx.ui.basic.Label(o);H.setTextColor(s);H.hide();this.add(H,{left:290,top:145});K.addListener(f,function(){H.show();E.setEnabled(false);D.setEnabled(false);},this);var D=new qx.ui.groupbox.GroupBox(l);this.add(D,{left:320,top:156,bottom:5});D.setWidth(270);D.setHeight(320);D.setAllowGrowY(false);D.setLayout(new qx.ui.layout.Grid(5,5));D.add(new qx.ui.basic.Label(m),{row:0,column:0});D.add(new qx.ui.basic.Label(j),{row:1,column:0});D.add(new qx.ui.basic.Label(B),{row:2,column:0});var name=new qx.ui.basic.Label();D.add(name,{row:0,column:1});var location=new qx.ui.basic.Label();D.add(location,{row:1,column:1});var J=new qx.ui.basic.Label();J.setRich(true);J.setWidth(150);J.setSelectable(true);D.add(J,{row:2,column:1});var G=new qx.data.controller.Object();G.addTarget(name,k,t);G.addTarget(location,k,w);G.addTarget(J,k,a,false,{converter:function(N){var M=N.split(y);for(var i=M.length-1;i>=0;i-- ){if(M[i].indexOf(d)==0){M[i]=x+M[i]+q+M[i]+p;};};return M.join(y);}});D.add(new qx.ui.basic.Label(A),{row:3,column:0});var L=new qx.ui.basic.Image();D.add(L,{row:3,column:1});G.addTarget(L,n,z);F.bind(g,G,u);},configureItem:function(O){O.setRich(true);O.getChildControl(h).setWidth(48);O.getChildControl(h).setHeight(48);O.getChildControl(h).setScale(true);}}});})();
});