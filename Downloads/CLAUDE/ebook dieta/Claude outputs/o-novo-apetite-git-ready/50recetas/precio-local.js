/* Precio local: muestra los precios en la moneda del visitante, igual que el checkout de Hotmart.
   Tasas tomadas del checkout Hotmart el 09/11/2026 (Edición Completa US$ 9):
   MX $205,32 (IVA incl.) · CO $30.730 · PE S/ 34 · CL $11.096 (IVA incl.) · EC US$ 9.
   Para actualizar: cambia "rate" (= precio local de la Completa / 9). */
(function () {
  var C = {
    MX: { rate: 205.32 / 9, sym: '$', dec: '.', th: ',', round: 1, name: 'pesos mexicanos', tax: ', IVA incluido' },
    CO: { rate: 30730 / 9, sym: '$', dec: ',', th: '.', round: 10, name: 'pesos colombianos', tax: '' },
    PE: { rate: 34 / 9, sym: 'S/ ', dec: '.', th: ',', round: 1, name: 'soles', tax: '' },
    CL: { rate: 11096 / 9, sym: '$', dec: ',', th: '.', round: 1, name: 'pesos chilenos', tax: ', IVA incluido' }
  };
  var TZ = {
    'America/Mexico_City': 'MX', 'America/Cancun': 'MX', 'America/Merida': 'MX', 'America/Monterrey': 'MX',
    'America/Matamoros': 'MX', 'America/Chihuahua': 'MX', 'America/Ojinaga': 'MX', 'America/Mazatlan': 'MX',
    'America/Bahia_Banderas': 'MX', 'America/Hermosillo': 'MX', 'America/Tijuana': 'MX', 'America/Ciudad_Juarez': 'MX',
    'America/Bogota': 'CO', 'America/Lima': 'PE',
    'America/Santiago': 'CL', 'America/Punta_Arenas': 'CL', 'Pacific/Easter': 'CL'
  };

  function country() {
    try {
      var q = (location.search.match(/[?&]pais=([A-Za-z]{2})/) || [])[1];
      if (q) return q.toUpperCase();
      var tz = Intl.DateTimeFormat().resolvedOptions().timeZone;
      if (TZ[tz]) return TZ[tz];
      var reg = ((navigator.language || '').split('-')[1] || '').toUpperCase();
      if (C[reg]) return reg;
    } catch (e) {}
    return null;
  }

  var k = country();
  var c = C[k];
  if (!c) return; // Ecuador, Brasil u otro país: se queda en dólares

  function num(usd) {
    var v = usd * c.rate;
    var digits = 0;
    if (v < 10 && c.round === 1) { digits = 2; } else { v = Math.round(v / c.round) * c.round; }
    var s = v.toFixed(digits).split('.');
    s[0] = s[0].replace(/\B(?=(\d{3})+(?!\d))/g, c.th);
    return s[1] ? s[0] + c.dec + s[1] : s[0];
  }
  function fmt(usd) { return c.sym + num(usd); }
  function parse(t) { return parseFloat(t.replace(',', '.')); }

  function run() {
    // 1) "US$" separado del número: <small>US$</small>15 · <span class="pf-cur">US$</span><span class="pf-amt">9</span>
    var all = document.body.getElementsByTagName('*');
    for (var i = 0; i < all.length; i++) {
      var el = all[i];
      if (el.children.length === 0 && el.textContent.trim() === 'US$') {
        var nx = el.nextSibling;
        while (nx && nx.nodeType === 3 && !nx.nodeValue.trim()) nx = nx.nextSibling;
        if (nx && /^\s*\d+([.,]\d+)?\s*$/.test(nx.textContent)) {
          el.textContent = c.sym.trim();
          nx.textContent = num(parse(nx.textContent.trim()));
        }
      }
    }
    // 2) Texto con "US$ 9", "US$ 0,17" y "3 centavos"
    var w = document.createTreeWalker(document.body, NodeFilter.SHOW_TEXT, null, false), n, list = [];
    while ((n = w.nextNode())) {
      var p = n.parentNode && n.parentNode.nodeName;
      if (p === 'SCRIPT' || p === 'STYLE') continue;
      if (/US\$|centavos/.test(n.nodeValue)) list.push(n);
    }
    list.forEach(function (t) {
      t.nodeValue = t.nodeValue
        .replace(/US\$\s?(\d+(?:,\d+)?)/g, function (m, v) { return fmt(parse(v)); })
        .replace(/(\d+)\s+centavos/g, function (m, v) { return fmt(parseInt(v, 10) / 100); });
    });
    document.title = document.title.replace(/US\$\s?(\d+(?:,\d+)?)/g, function (m, v) { return fmt(parse(v)); });

    // 3) Aviso de moneda debajo de los precios principales
    var note = 'Precio en ' + c.name + c.tax + '. Pagas en tu moneda, sin conversión.';
    var boxes = document.querySelectorAll('.pf-price, .fc-price, .up-price, .new');
    for (var j = 0; j < boxes.length; j++) {
      if (!/\d/.test(boxes[j].textContent)) continue;
      var d = document.createElement('div');
      d.className = 'precio-local-nota';
      d.textContent = note;
      d.style.cssText = 'font-size:12px;opacity:.75;margin-top:6px;line-height:1.3;flex-basis:100%;width:100%;text-align:center;';
      boxes[j].parentNode.insertBefore(d, boxes[j].nextSibling);
    }
    document.documentElement.setAttribute('data-pais', k);
  }

  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', run);
  else run();
})();
