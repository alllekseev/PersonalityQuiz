//
//  QuestionViewController.swift
//  PersonalityQuiz
//
//  Created by Олег Алексеев on 07.04.2023.
//

import UIKit

class QuestionViewController: UIViewController {
    
    
    @IBOutlet weak var questionLabel: UILabel!
    
    
    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet weak var singleButton1: UIButton!
    @IBOutlet weak var singleButton2: UIButton!
    @IBOutlet weak var singleButton3: UIButton!
    @IBOutlet weak var singleButton4: UIButton!
    
    
    @IBOutlet weak var multipleStackView: UIStackView!
    @IBOutlet weak var multiLabel1: UILabel!
    @IBOutlet weak var multiLabel2: UILabel!
    @IBOutlet weak var multiLabel3: UILabel!
    @IBOutlet weak var multiLabel4: UILabel!
    @IBOutlet weak var multiSwitch1: UISwitch!
    @IBOutlet weak var multiSwitch2: UISwitch!
    @IBOutlet weak var multiSwitch3: UISwitch!
    @IBOutlet weak var multiSwitch4: UISwitch!
    
    @IBOutlet weak var rangedStackView: UIStackView!
    @IBOutlet weak var rangedLabel1: UILabel!
    @IBOutlet weak var rangedLabel2: UILabel!
    @IBOutlet weak var rangedSlider: UISlider!
    
    @IBOutlet weak var questionProgressView: UIProgressView!
    
    var questions: [Question] = [
      Question(
        text: "Что Вы любите большего всего есть?",
        type: .single,
        answers: [
          Answer(text: "Стейк", type: .dog),
          Answer(text: "Рыба", type: .cat),
          Answer(text: "Марковка", type: .rabbit),
          Answer(text: "Кукуруза", type: .turtle)
        ]
      ),
      
      Question(
        text: "Что Вы любите делать?",
        type: .multiple,
        answers: [
          Answer(text: "Плавать", type: .turtle),
          Answer(text: "Спать", type: .cat),
          Answer(text: "Обниматься", type: .rabbit),
          Answer(text: "Кушать", type: .dog)
        ]
      ),
      
      Question(
        text: "Насколько Вам нравятся поездки на автомобиле?",
        type: .ranged,
        answers: [
          Answer(text: "Мне не нравиться", type: .cat),
          Answer(text: "Я немного нервничаю", type: .rabbit),
          Answer(text: "Я едва замечаю их", type: .turtle),
          Answer(text: "Мне они нравятся", type: .dog)
        ]
      )
    ]
    
    var questionIndex = 0
    var answersChoosen: [Answer] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
    }
    
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        
        let currentAnswers = questions[questionIndex].answers
        
        switch sender {
        case singleButton1:
            answersChoosen.append(currentAnswers[0])
        case singleButton2:
            answersChoosen.append(currentAnswers[1])
        case singleButton3:
            answersChoosen.append(currentAnswers[2])
        case singleButton4:
            answersChoosen.append(currentAnswers[3])
        default:
            break
        }
        
        nextQuestion()
    }
    
    @IBAction func multipleAnswerButtonPressed() {
        let currentAnswers = questions[questionIndex].answers
        
        if multiSwitch1.isOn {
            answersChoosen.append(currentAnswers[0])
        }
        if multiSwitch2.isOn {
            answersChoosen.append(currentAnswers[1])
        }
        if multiSwitch3.isOn {
            answersChoosen.append(currentAnswers[2])
        }
        if multiSwitch4.isOn {
            answersChoosen.append(currentAnswers[3])
        }
        
        nextQuestion()
    }
    
    @IBAction func rangedAnswerButtonPressed() {
        let currentAnswers = questions[questionIndex].answers
        let index = Int(round(rangedSlider.value * Float(currentAnswers.count - 1)))
        
        answersChoosen.append(currentAnswers[index])
        
        nextQuestion()
    }
    
    
    func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
        } else {
            performSegue(withIdentifier: "Results", sender: nil)
        }
    }
    
    @IBSegueAction func showResults(_ coder: NSCoder) -> ResultViewController? {
        return ResultViewController(coder: coder, responses: answersChoosen)
    }
    func updateSingleStack(using answers: [Answer]) {
        singleStackView.isHidden = false
        singleButton1.setTitle(answers[0].text, for: .normal)
        singleButton2.setTitle(answers[1].text, for: .normal)
        singleButton3.setTitle(answers[2].text, for: .normal)
        singleButton4.setTitle(answers[3].text, for: .normal)
    }
    
    func updateMultipleStack(using answers: [Answer]) {
        multipleStackView.isHidden = false
        multiSwitch1.isOn = false
        multiSwitch2.isOn = false
        multiSwitch3.isOn = false
        multiSwitch4.isOn = false
        multiLabel1.text = answers[0].text
        multiLabel2.text = answers[1].text
        multiLabel3.text = answers[2].text
        multiLabel4.text = answers[3].text
    }
    
    func updateRangedStack(using answers: [Answer]) {
        rangedStackView.isHidden = false
        rangedSlider.setValue(0.5, animated: false)
        rangedLabel1.text = answers.first?.text
        rangedLabel2.text = answers.last?.text
    }
    
    func updateUI() {
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangedStackView.isHidden = true
        
        let currentQuestion = questions[questionIndex]
        let currentAnswers = currentQuestion.answers
        let totalProgress = Float(questionIndex) / Float(questions.count)
        
        
        navigationItem.title = "Вопрос #\(questionIndex + 1)"
        questionLabel.text = currentQuestion.text
        questionProgressView.setProgress(totalProgress, animated: true)
        
        
        switch currentQuestion.type {
        case .single:
            updateSingleStack(using: currentAnswers)
        case .multiple:
            updateMultipleStack(using: currentAnswers)
        case .ranged:
            updateRangedStack(using: currentAnswers)
        }
    }
    
}
