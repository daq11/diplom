$ ->
  loadMathJax()
  $(document).on 'page:load', loadMathJax

loadMathJax = ->
  window.MathJax = null
  $.getScript "http://edu.msiu.ru/mathjax/MathJax.js?config=TeX-AMS-MML_SVG-full", ->
    MathJax.Hub.Config
      jax: [
        "input/TeX"
        "output/SVG"
      ]
      tex2jax:
        inlineMath: [[
          "\\("
          "\\)"
        ]]
        displayMath: [[
          "\\["
          "\\]"
        ]]
    
      "HTML-CSS":
        imageFont: null
    
      SVG:
        linebreaks:
          automatic: true
    
    (->
      cookie = MathJax.HTML.Cookie.Get("menu")
      if cookie.renderer and cookie.renderer isnt "SVG"
        cookie.renderer = "SVG"
        MathJax.HTML.Cookie.Set "menu", cookie
      return
    )()
