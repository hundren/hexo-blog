<div class="copyright" style="text-align:center">{#
#}{% set current = date(Date.now(), "YYYY") %}{#
#}&copy; {% if theme.footer.since and theme.footer.since != current %}{{ theme.footer.since }} &mdash; {% endif %}{#
#}<span itemprop="copyrightYear">{{ current }}</span>
  <span class="with-love">
    <i class="fa fa-{{ theme.footer.icon }}"></i>
  </span>
  <a  href='javascript:' onclick="high()" class="author" itemprop="copyrightHolder">{{ theme.footer.copyright || config.author }}(不要点这里)</a>
  {% if theme.post_wordcount.totalcount %}
    <span class="post-meta-divider">|</span>
    <span class="post-meta-item-icon">
      <i class="fa fa-area-chart"></i>
    </span>
    {% if theme.post_wordcount.item_text %}
      <span class="post-meta-item-text">{{ __('post.totalcount') }}&#58;</span>
    {% endif %}
    <span title="{{ __('post.totalcount') }}">{#
    #}{{ totalcount(site, '0,0.0a') }}{#
  #}</span>
  {% endif %}
</div>

{% if theme.footer.powered %}
  <div class="powered-by">{#
  #}{{ __('footer.powered', '<a class="theme-link" target="_blank" href="https://hexo.io">Hexo</a>') }}{#
#}</div>
{% endif %}

{% if theme.footer.powered and theme.footer.theme.enable %}
  <span class="post-meta-divider">|</span>
{% endif %}

{% if theme.footer.theme.enable %}
  <div class="theme-info">{#
  #}{{ __('footer.theme') }} &mdash; {#
  #}<a class="theme-link" target="_blank" href="https://github.com/iissnan/hexo-theme-next">{#
    #}NexT.{{ theme.scheme }}{#
  #}</a>{% if theme.footer.theme.version %} v{{ theme.version }}{% endif %}{#
#}</div>
{% endif %}
{% if theme.footer.custom_text %}
  <div class="footer-custom" style="text-align:center">{#
  #}{{ theme.footer.custom_text }}{#
#}</div>
{% endif %}
<script>

function show_popup(text,color){
    var alert_dom = document.createElement('div')
    alert_dom.setAttribute('style',"position:fixed;left:50%;top:20px;transform:translate(-50%, 0);padding: 0px 20px;    background-color: #000;color: #fff;font-weight: bold;font-size: 22px;border-radius: 4px;")
    if(color){
      alert_dom.style.color = color
    }
    alert_dom.innerHTML = text
    document.body.appendChild(alert_dom)
    setTimeout(() => {
      document.body.removeChild(alert_dom)
    }, 2000);
}
/*
    * 频率控制 返回函数连续调用时，fn 执行频率限定为每多少时间执行一次
    * @param fn {function}  需要调用的函数
    * @param delay  {number}    延迟时间，单位毫秒
    * @param immediate  {bool} 给 immediate参数传递false 绑定的函数先执行，而不是delay后后执行。
    * @return {function}实际调用函数
    */
    var throttle = function (fn,delay, immediate, debounce) {
       var curr = +new Date(),//当前事件
           last_call = 0,
           last_exec = 0,
           timer = null,
           diff, //时间差
           context,//上下文
           args,
           exec = function () {
               last_exec = curr;
               fn.apply(context, args);
           };
       return function () {
           curr = +new Date();
           context = this,
           args = arguments,
           diff = curr - (debounce ? last_call : last_exec) - delay;
           clearTimeout(timer);
           if (debounce) {
               if (immediate) {
                   timer = setTimeout(exec, delay);
               } else if (diff >= 0) {
                   exec();
               }
           } else {
               if (diff >= 0) {
                   exec();
               } else if (immediate) {
                   timer = setTimeout(exec, -diff);
               }
           }
           last_call = curr;
       }
    };

    /*
    * 空闲控制 返回函数连续调用时，空闲时间必须大于或等于 delay，fn 才会执行
    * @param fn {function}  要调用的函数
    * @param delay   {number}    空闲时间
    * @param immediate  {bool} 给 immediate参数传递false 绑定的函数先执行，而不是delay后后执行。
    * @return {function}实际调用函数
    */
    var debounce = function (fn, delay, immediate) {
       return throttle(fn, delay, immediate, true);
    };

    var high = debounce (function() {
      var i=Math.round((Math.random() * (5 - 1) + 1));
      // i=5
      switch(i){
      case 1:show_popup("恭喜你获得称号-无聊的使者。");break;
      case 2:show_popup("继续发掘可能会有精彩");break;
      case 3:show_popup("今天天气不错");break;
      case 4:show_popup("据说打赏一下会有彩蛋");break;
      case 5:show_popup("恭喜你触发彩蛋并获得称号-好奇大师",'red');
    function c() {
            var e = document.createElement("link");
            e.setAttribute("type", "text/css");
            e.setAttribute("rel", "stylesheet");
            e.setAttribute("href", f);
            e.setAttribute("class", l);
            document.body.appendChild(e)
        }

        function h() {
            var e = document.getElementsByClassName(l);
            for (var t = 0; t < e.length; t++) {
                document.body.removeChild(e[t])
            }
        }

        function p() {
            var e = document.createElement("div");
            e.setAttribute("class", a);
            document.body.appendChild(e);
            setTimeout(function() {
                document.body.removeChild(e)
            }, 100)
        }

        function d(e) {
            return {
                height : e.offsetHeight,
                width : e.offsetWidth
            }
        }

        function v(i) {
            var s = d(i);
            return s.height > e && s.height < n && s.width > t && s.width < r
        }

        function m(e) {
            var t = e;
            var n = 0;
            while (!!t) {
                n += t.offsetTop;
                t = t.offsetParent
            }
            return n
        }

        function g() {
            var e = document.documentElement;
            if (!!window.innerWidth) {
                return window.innerHeight
            } else if (e && !isNaN(e.clientHeight)) {
                return e.clientHeight
            }
            return 0
        }

        function y() {
            if (window.pageYOffset) {
                return window.pageYOffset
            }
            return Math.max(document.documentElement.scrollTop, document.body.scrollTop)
        }

        function E(e) {
            var t = m(e);
            return t >= w && t <= b + w
        }

        function S() {
            var e = document.createElement("audio");
            e.setAttribute("class", l);
            e.src = i;
            e.loop = false;
            e.addEventListener("canplay", function() {
                setTimeout(function() {
                    x(k)
                }, 500);
                setTimeout(function() {
                    N();
                    p();
                    for (var e = 0; e < O.length; e++) {
                        T(O[e])
                    }
                }, 15500)
            }, true);
            e.addEventListener("ended", function() {
                N();
                h()
            }, true);
            e.innerHTML = " <p>If you are reading this, it is because your browser does not support the audio element. We recommend that you get a new browser.</p> <p>";
            document.body.appendChild(e);
            e.play()
        }

        function x(e) {
            e.className += " " + s + " " + o
        }

        function T(e) {
            e.className += " " + s + " " + u[Math.floor(Math.random() * u.length)]
        }

        function N() {
            var e = document.getElementsByClassName(s);
            var t = new RegExp("\\b" + s + "\\b");
            for (var n = 0; n < e.length; ) {
                e[n].className = e[n].className.replace(t, "")
            }
        }

        var e = 30;
        var t = 30;
        var n = 350;
        var r = 350;
        var i = "/shake.mp3";
        var s = "mw-harlem_shake_me";
        var o = "im_first";
        var u = ["im_drunk", "im_baked", "im_trippin", "im_blown"];
        var a = "mw-strobe_light";
        var f = "/harlem-shake-style.css";
        var l = "mw_added_css";
        var b = g();
        var w = y();
        var C = document.getElementsByTagName("*");
        var k = null;
        for (var L = 0; L < C.length; L++) {
            var A = C[L];
            if (v(A)) {
                if (E(A)) {
                    k = A;
                    break
                }
            }
        }
        if (A === null) {
            console.warn("Could not find a node of the right size. Please try a different page.");
            return
        }
        c();
        S();
        var O = [];
        for (var L = 0; L < C.length; L++) {
            var A = C[L];
            if (v(A)) {
                O.push(A)
            }
        }
    }
},2000, false, true)
</script>
