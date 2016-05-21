describe('home.js', function() {
  var house = {
    users_count: 0,
    rooms : 4,
    id : 1,
    address: "sodihfdi shfi idiojis",
    image_url: "sañjod osjfodpspojs",
    groups_count: 1
  }

  it("getHousesFromResponse", function() {
    expect(getHousesFromResponse([house])).not.toBe(null);
  });

  it("getHousesFromResponse", function() {
    expect(getHousesFromResponse([house])).toContain(house.address);
  });

  it("houseToHTML", function() {
    expect(houseToHTML(house)).not.toBe(null);
  });

  it("houseToHTML", function() {
    expect(houseToHTML(house)).toContain(house.address);
  });
});