// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require_tree .

function questionAnswerPrepare(){
    var $selectAnswerType = $("#question_answer_type");
    var $answerContainer  = $("#answer_container");
    var $addNewAnswer     = $("#add_new_answer");
    var count             = 0;
    var $currentCount     = $("#currentCount"); // во вьюшке формы должен быть этот тег, в котором хранится индекс для нового добавляемого ответа
    if($currentCount.length)
        count = parseInt($currentCount.val())-1;
    if(count < 0)
        count = 0;
    function prepareHtml(){
        $answerContainer.html('');
        count = 0;
        switch(parseInt($selectAnswerType.val())){
            case 0: // ручной ввод
                $answerContainer.append('<b>Правильные варианты ответа:</b>');
                $answerContainer.append('<input type="text" name="question[answer_array]['+count+']" class="form-control"><br>');
                break;
            case 1: // выбор из списка
            default:
                $answerContainer.append('<b>Варианты ответа:</b>');
                htmlString = '';
                htmlString += '<div class="row">';
                htmlString += '<div class="col-xs-8"><input type="text" name="question[answer_array]['+count+'][0]" class="form-control"></div>';
                htmlString += '<div class="col-xs-4">Это правильный ответ: <input type="checkbox" value="right" name="question[answer_array]['+count+'][1]" class="form-control"></div>';
                htmlString += '</div>';
                $answerContainer.append(htmlString);
                break;
        }
    }
    if($answerContainer.length && $selectAnswerType.length) {
        $selectAnswerType.change(prepareHtml);
        $addNewAnswer.click(function(){
            count++;
            switch(parseInt($selectAnswerType.val())){
                case 0: // ручной ввод
                    $answerContainer.append('<input type="text" name="question[answer_array]['+count+']" class="form-control"><br>');
                    break;
                case 1: // выбор из списка
                default:
                    htmlString = '';
                    htmlString += '<div class="row">';
                    htmlString += '<div class="col-xs-8"><input type="text" name="question[answer_array]['+count+'][0]" class="form-control"></div>';
                    htmlString += '<div class="col-xs-4">Это правильный ответ: <input type="checkbox" value="right" name="question[answer_array]['+count+'][1]" class="form-control"></div>';
                    htmlString += '</div>';
                    $answerContainer.append(htmlString);
                    break;
            };
            return false;
        });
    }
}

$(document).ready(questionAnswerPrepare);
$(document).on('page:load', questionAnswerPrepare);

function goAnswer(){
    var $question = $("#question");
    function checkAnswer(id, answer){
        $.ajax({
            type: "POST",
            url: "/checkAnswer",
            data: "questionID="+id+"&answer="+answer,
            success: function(msg){
                alert(msg.message);
                if(msg.status == 'OK'){
                   location.reload();
                }
            }
        });
    }
    if($question.length) {
        var questionID = $question.data('question-id');
        var $btn = $("#go_answer");
        var $inputAnswer = $("#answer");
        var $answers = $(".answer");
        var answer = '';
        if ($btn.length && $inputAnswer.length) {//текстовый вопрос
            $btn.click(function () {
                answer = $inputAnswer.val();
                checkAnswer(questionID, answer);
                return false;
            })
        } else if ($answers) {
            $answers.click(function () {
                answer = $(this).data('answer');
                checkAnswer(questionID, answer);
                return false;
            })
        }
    }
}

$(document).ready(goAnswer);
$(document).on('page:load', goAnswer);