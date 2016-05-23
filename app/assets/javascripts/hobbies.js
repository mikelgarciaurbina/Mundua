$(document).ready(function() {
  if(window.location.pathname == "/profile"){
    Mundua.getUserData("/api/v1/hobbies").then(getHobbies);
  }
});

function getHobbies(hobbies){
  arrayHobbies = JSON.parse(hobbies).map(function(hobby) {
    return hobby.name;
  });
  var hobbies = new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.whitespace,
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    local: arrayHobbies
  });

  $('#hobby .typeahead').typeahead({
    hint: true,
    highlight: true,
    minLength: 1
  },
  {
    name: 'hobbies',
    source: hobbies
  });
}