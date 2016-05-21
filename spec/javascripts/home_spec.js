describe('home.js', function() {
  var city = {
    cost: {
      beer_in_cafe : {
        USD: 100
      },
      longTerm: {
        USD: 120
      }
    },
    info : {
      weather: {
        temperature : {
          celsius : 20
        },
        humidity: {
          value: 30
        }
      },
      location: {
        latitude: 34,
        longitude: 22
      },
      internet: {
        speed: {
          download: 23
        }
      },
      city: {
        name: "pdjf"
      },
      country: {
        name: "wed"
      }
    },
    scores : {
      nightlife: 40,
      safety: 50
    },
    media: {
      image: {
        '500': "sdfds"
      }
    }
  }

  it("getCityFromResponse", function() {
    expect(getCityFromResponse([city])).not.toBe(null);
  });

  it("getCityFromResponse", function() {
    expect(getCityFromResponse([city])).toContain(city.info.city.name);
  });

  it("getStatistics", function() {
    expect(getStatistics(city)).not.toBe(null);
  });

  it("cityToHTML", function() {
    expect(cityToHTML(city)).not.toBe(null);
  });

  it("cityToHTML", function() {
    expect(cityToHTML(city)).toContain(city.info.city.name);
  });

  it("addEventsToLinks", function() {
    elem = document.createElement("div");
    elem.classList.add("js-login")
    elem.innerHTML = "my Text";
    document.body.appendChild(elem,document.body.childNodes[0]);
    var login = document.getElementsByClassName("js-login")[0];
    addEventsToLinks();
    expect(login.onclick).not.toBe(null);
  });
  it("not addEventsToLinks", function() {
    elem = document.createElement("div");
    elem.classList.add("js-login2")
    elem.innerHTML = "my Text";
    document.body.appendChild(elem,document.body.childNodes[0]);
    var login = document.getElementsByClassName("js-login2")[0];
    expect(login.onclick).toBe(null);
  });

  it("getModal", function() {
    elem = document.createElement("div");
    elem.classList.add("js-login3")
    elem.innerHTML = "my Text";
    document.body.appendChild(elem,document.body.childNodes[0]);
    var login = document.getElementsByClassName("js-login3")[0];
    expect(getModal("js-login3")).toBe(login);
  });

  it("fillModal", function() {
    elem = document.createElement("div");
    elem.classList.add("js-login4")
    elem.innerHTML = "my Text";
    document.body.appendChild(elem,document.body.childNodes[0]);
    var login = document.getElementsByClassName("js-login4")[0];
    result = "<html><head></head><body>hola</body></html>";
    fillModal(login, result);
    expect(login.innerHTML).toBe("hola");
  });

  it("openModal", function() {
    openModal();
    expect(document.location.href).toContain("#modal");
  });

  it("getBodyToHtml", function() {
    result = "<html><head></head><body>hola</body></html>";
    expect(getBodyToHtml(result)).toBe("hola");
  });
});