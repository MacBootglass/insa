var etat = ['Neutre', 'Triste', 'Heureux'];
var regex = /^[-a-z0-9~!$%^&*_=+}{\'?]+(\.[-a-z0-9~!$%^&*_=+}{\'?]+)*@([a-z0-9_][-a-z0-9_]*(\.[-a-z0-9_]+)*\.(aero|arpa|biz|com|coop|edu|gov|info|int|mil|museum|name|net|org|pro|travel|mobi|[a-z][a-z])|([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}))(:[0-9]{1,5})?$/i;

$(document).ready(function() {
  var content = "";
  // content = generateLink();
  content += '<div id="tromboneGroup"><img src="" alt="trombone" id="trombone"/><span id="tromboneText"></span></div>';

  $("body").append(content);

  $(".expression").on("click", function(e) {
    agent($(this).data("value"), 20, 600, "Je suis un message de test");
  });

  // $("input").on("input", function() {
  //   agent(etat[0], $(this).position().top, 550, "Je surveille votre saisie");
  // });

  $("#name, #surname").on("focus", function() {
    controlName(this);
  });

  $("#name, #surname").on("input", function() {
    controlName(this);
  });

  $("#name, #surname").on("blur", function() {
    controlName(this);
    controlInput(this);
  });



  $("#email").on("focus", function() {
    controlEmail(this);
  });

  $("#email").on("input", function() {
    controlEmail(this);
  });

  $("#email").on("blur", function() {
    controlEmail(this);
    controlInput(this);
  });
});

function controlName(tag) {
  var champ = $(tag);
  if (tag.value.length <=  0) {
    agent(etat[1], champ.position().top, 550, "Vous devez saisir un nom");
  }
  else {
    agent(etat[2], champ.position().top, 550, "Parfait");
  }
}

function controlEmail(tag) {
  var champ = $(tag);
  if (tag.value.match(regex) == null) {
    agent(etat[1], champ.position().top, 550, "Vous devez saisir un email valide");
  }
  else {
    agent(etat[2], champ.position().top, 550, "Parfait");
  }
}

function controlInput(tag) {
  var champ = $(tag);
  if (tag.value.length <=  0) {
    champ.css("border-color", 'red');
  }
  else {
    champ.css("border-color", 'green');
  }
}

function generateLink() {
  var content = "<div>";
  for (var i=0; i<etat.length; i++) {
    content += '<a href="#" class="expression" data-value="' + etat[i] + '">' + etat[i] + '</a>';
  }
  content += '</div>';
  return content;
}

function agent(expression, top, left, text) {
  var trombone = $("#trombone");
  var tromboneGroup = $("#tromboneGroup");
  var tromboneText = $("#tromboneText");

  if (top < 0) {
    top = 0;
  }

  if (left < 0) {
    left = 0;
  }

  tromboneGroup.css("top", top);
  tromboneGroup.css("left", left);
  tromboneText.text(text);

  switch (expression) {
    case etat[0]:
      trombone.attr("src", "images/neutre.png");
      tromboneText.css("background-color", "gray");
      break;
    case etat[1]:
      trombone.attr("src", "images/sad.png");
      tromboneText.css("background-color", "red");
      break;
    case etat[2]:
      trombone.attr("src", "images/happy.png");
      tromboneText.css("background-color", "green");
      break;
  }

  tromboneGroup.show();
}
