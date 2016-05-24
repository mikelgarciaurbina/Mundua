$(document).ready(function() {
  if(window.location.pathname == "/profile") {
    Mundua.getUserData("/api/v1/technologies").then(getTechnologies);
  }
});

function getTechnologies(technologies) {
  arrayTechnologies = JSON.parse(technologies).map(function(technology) {
    return technology.name;
  });
  var technologies = new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.whitespace,
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    local: arrayTechnologies
  });
  
  $('#technology .typeahead').typeahead({
    hint: true,
    highlight: true,
    minLength: 1
  }, {
    name: 'technologies',
    source: technologies
  });
}