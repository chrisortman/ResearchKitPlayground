//: Please build the scheme 'ResearchKitPlayground' first
import XCPlayground
XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

import ResearchKit

var str = "Hello, playground"

var x = 10

for index in 1...20 {
    let y = index * x--
}

var steps = [ORKStep]()

let instructionStep = ORKInstructionStep(identifier: "IntroStep")
instructionStep.title = "The Questions Three"
instructionStep.text = "Who would cross the Bridge of Death must answer me these questions three, ere the otherside they see"
steps += [instructionStep]

steps += [
    ORKQuestionStep(identifier: "Q1", title: "This the first question", answer: ORKAnswerFormat.scaleAnswerFormatWithMaximumValue(10, minimumValue: 1, defaultValue: 1, step: 1, vertical: true, maximumValueDescription: nil, minimumValueDescription: nil)),
    ORKQuestionStep(identifier: "Q2", title: "This the second question", answer: ORKAnswerFormat.dateTimeAnswerFormat()),
    ORKQuestionStep(identifier: "Q3", title: "Three", answer: ORKAnswerFormat.locationAnswerFormat()),
]

let summaryStep = ORKCompletionStep(identifier: "SummaryStep")
summaryStep.title = "Right. Off you go!"
summaryStep.text = "That was easy!"
steps += [summaryStep]

let selector = ORKResultSelector(resultIdentifier: "Q1")
let emailPredicate = ORKResultPredicate.predicateForScaleQuestionResultWithResultSelector(selector, expectedAnswer: 4)
let navRule = ORKPredicateStepNavigationRule(resultPredicates: [emailPredicate], destinationStepIdentifiers: ["SummaryStep"], defaultStepIdentifier: "Q2", validateArrays: false)

let task = ORKNavigableOrderedTask(identifier: "SurveyTask", steps: steps)
task.setNavigationRule(navRule, forTriggerStepIdentifier: "Q1")



let myController = UIViewController()
XCPlaygroundPage.currentPage.liveView = myController

var taskViewController = ORKTaskViewController(task: task, taskRunUUID: nil)
myController.presentViewController(taskViewController, animated: true, completion: nil)


taskViewController

