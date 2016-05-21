describe('houses.js', function() {
  var place = {
    geometry: {
      location: {
        lat: function(){
          return "10";
        },
        lng: function(){
          return "20";
        }
      }
    }
  }
  it("setLatToAllDivs", function() {
    elem = document.createElement("input");
    elem.classList.add("js-latitude")
    document.body.appendChild(elem,document.body.childNodes[0]);
    setLatToAllDivs("js-latitude", place);
    expect(document.getElementsByClassName("js-latitude")[0].value).toBe("10");
  });

  it("setLngToAllDivs", function() {
    elem = document.createElement("input");
    elem.classList.add("js-longitude")
    document.body.appendChild(elem,document.body.childNodes[0]);
    setLngToAllDivs("js-longitude", place);
    expect(document.getElementsByClassName("js-longitude")[0].value).toBe("20");
  });
});