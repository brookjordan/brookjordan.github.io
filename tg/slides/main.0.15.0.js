'use strict';

var tgQuestionnaire = runTGQuestionnaire(questions, { initialQuestion: initialQuestion, failureQuestion: failureQuestion, failureQuestions: failureQuestions, maxNoCount: maxNoCount, winCount: winCount }).on('finish', function (answers, rounds) {
  console.log('Sucess! —');
  logAnswers(answers);
}).on('fail', function (answers, rounds) {
  console.log('Failure —');
  logAnswers(answers);
}).on('restart', function (answers, rounds) {
  console.log('Restart —');
  logAnswers(answers);
});

function logAnswers(answers) {
  console.table ? console.table(answers) : console.log(JSON.stringify(answers));
}