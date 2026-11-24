//
//  QuestionSet.swift
//  MyApps
//
//  Created by GaoZiHan on 2026-11-24.
//  This code was generated using GitHub Copilot: question-set progression structure.
//  The question sets and their content are my own.

import Foundation

enum Difficulty: String, CaseIterable, Identifiable, Codable {
    case easy = "Easy"
    case normal = "Normal"
    case hard = "Hard"

    var id: String {
        rawValue
    }
}

struct QuestionSet: Identifiable {
    let id: UUID = UUID()
    let setName: String
    let subject: Subject
    let difficulty: Difficulty
    let questions: [Question]
    var isCompleted = false

    init(
        setName: String,
        subject: Subject,
        difficulty: Difficulty,
        questions: [Question],
        isCompleted: Bool = false
    ) {
        precondition(
            questions.count == 10,
            "Every question set must contain exactly 10 questions."
        )

        self.setName = setName
        self.subject = subject
        self.difficulty = difficulty
        self.questions = questions
        self.isCompleted = isCompleted
    }

    static let sampleQuestionSets: [QuestionSet] = [
        mathematicsSampleSet,
        scienceSampleSet,
        historySampleSet,
        frenchSampleSet
    ]

    static let questionSetProgression: [QuestionSet] = [
        mathematicsSampleSet,
        scienceSampleSet,
        historySampleSet,
        frenchSampleSet,
        mathematicsSecondSet,
        scienceSecondSet,
        historySecondSet,
        frenchSecondSet
    ]

    static func retryQuestionSet(for questionSet: QuestionSet) -> QuestionSet? {
        for availableSet in questionSetProgression {
            if availableSet.subject == questionSet.subject
                && availableSet.setName != questionSet.setName {
                return availableSet
            }
        }
        return nil
    }

    private static let mathematicsSampleSet = QuestionSet(
        setName: "Math Explorers",
        subject: .mathematics,
        difficulty: .normal,
        questions: [
            Question(
                questionText: "What is 7 + 8?",
                answerOptions: ["A. 12", "B. 13", "C. 15", "D. 16"],
                correctAnswer: "C. 15",
                explanation: "Adding 7 and 8 gives 15.",
                subject: .mathematics
            ),
            Question(
                questionText: "What is 6 × 4?",
                answerOptions: ["A. 10", "B. 20", "C. 24", "D. 28"],
                correctAnswer: "C. 24",
                explanation: "Six groups of four make 24.",
                subject: .mathematics
            ),
            Question(
                questionText: "Which fraction is equal to one half?",
                answerOptions: ["A. 1/3", "B. 2/4", "C. 3/4", "D. 4/5"],
                correctAnswer: "B. 2/4",
                explanation: "Two out of four equal parts is one half.",
                subject: .mathematics
            ),
            Question(
                questionText: "What is the perimeter of a square with sides of 5 cm?",
                answerOptions: ["A. 10 cm", "B. 15 cm", "C. 20 cm", "D. 25 cm"],
                correctAnswer: "C. 20 cm",
                explanation: "A square has four equal sides, so 4 × 5 = 20 cm.",
                subject: .mathematics
            ),
            Question(
                questionText: "Which number is even?",
                answerOptions: ["A. 17", "B. 23", "C. 31", "D. 42"],
                correctAnswer: "D. 42",
                explanation: "An even number can be divided by 2 with no remainder.",
                subject: .mathematics
            ),
            Question(
                questionText: "What is 100 − 37?",
                answerOptions: ["A. 53", "B. 63", "C. 67", "D. 73"],
                correctAnswer: "B. 63",
                explanation: "Subtracting 37 from 100 gives 63.",
                subject: .mathematics
            ),
            Question(
                questionText: "How many sides does a hexagon have?",
                answerOptions: ["A. 5", "B. 6", "C. 7", "D. 8"],
                correctAnswer: "B. 6",
                explanation: "The prefix hex- means six.",
                subject: .mathematics
            ),
            Question(
                questionText: "What is 3,000 + 400 + 20 + 6?",
                answerOptions: ["A. 3,246", "B. 3,426", "C. 3,462", "D. 3,624"],
                correctAnswer: "B. 3,426",
                explanation: "The digits represent 3,000 + 400 + 20 + 6 = 3,426.",
                subject: .mathematics
            ),
            Question(
                questionText: "A clock shows 3:30. Where is the minute hand?",
                answerOptions: ["A. On 3", "B. On 6", "C. On 9", "D. On 12"],
                correctAnswer: "B. On 6",
                explanation: "Thirty minutes places the minute hand on 6.",
                subject: .mathematics
            ),
            Question(
                questionText: "What is 45 ÷ 5?",
                answerOptions: ["A. 7", "B. 8", "C. 9", "D. 10"],
                correctAnswer: "C. 9",
                explanation: "Five groups of nine make 45.",
                subject: .mathematics
            )
        ]
    )

    private static let scienceSampleSet = QuestionSet(
        setName: "Science Detectives",
        subject: .science,
        difficulty: .easy,
        questions: [
            Question(
                questionText: "What gas do humans need to breathe?",
                answerOptions: ["A. Oxygen", "B. Helium", "C. Smoke", "D. Steam"],
                correctAnswer: "A. Oxygen",
                explanation: "Humans need oxygen from the air to live.",
                subject: .science
            ),
            Question(
                questionText: "Which part of a plant takes in water?",
                answerOptions: ["A. Flower", "B. Leaf", "C. Root", "D. Fruit"],
                correctAnswer: "C. Root",
                explanation: "Roots take in water and nutrients from the soil.",
                subject: .science
            ),
            Question(
                questionText: "What force pulls objects toward Earth?",
                answerOptions: ["A. Light", "B. Gravity", "C. Sound", "D. Heat"],
                correctAnswer: "B. Gravity",
                explanation: "Gravity pulls objects toward the center of Earth.",
                subject: .science
            ),
            Question(
                questionText: "Which state of matter keeps its own shape?",
                answerOptions: ["A. Solid", "B. Liquid", "C. Gas", "D. Vapor"],
                correctAnswer: "A. Solid",
                explanation: "A solid keeps its own shape and takes up space.",
                subject: .science
            ),
            Question(
                questionText: "What is the closest star to Earth?",
                answerOptions: ["A. The Moon", "B. Mars", "C. The Sun", "D. Jupiter"],
                correctAnswer: "C. The Sun",
                explanation: "The Sun is the star at the center of our solar system.",
                subject: .science
            ),
            Question(
                questionText: "Which animal group has feathers?",
                answerOptions: ["A. Mammals", "B. Fish", "C. Reptiles", "D. Birds"],
                correctAnswer: "D. Birds",
                explanation: "Birds are animals with feathers and beaks.",
                subject: .science
            ),
            Question(
                questionText: "What do we use to see very small objects?",
                answerOptions: ["A. Microscope", "B. Telescope", "C. Compass", "D. Thermometer"],
                correctAnswer: "A. Microscope",
                explanation: "A microscope makes tiny objects look larger.",
                subject: .science
            ),
            Question(
                questionText: "What happens to water when it freezes?",
                answerOptions: ["A. It becomes ice", "B. It becomes steam", "C. It disappears", "D. It becomes sand"],
                correctAnswer: "A. It becomes ice",
                explanation: "Freezing changes liquid water into solid ice.",
                subject: .science
            ),
            Question(
                questionText: "Which organ pumps blood through the body?",
                answerOptions: ["A. Brain", "B. Heart", "C. Stomach", "D. Lung"],
                correctAnswer: "B. Heart",
                explanation: "The heart pumps blood to all parts of the body.",
                subject: .science
            ),
            Question(
                questionText: "What is a habitat?",
                answerOptions: ["A. An animal's home", "B. A type of cloud", "C. A kind of rock", "D. A food chain"],
                correctAnswer: "A. An animal's home",
                explanation: "A habitat is the place where a plant or animal lives.",
                subject: .science
            )
        ]
    )

    private static let historySampleSet = QuestionSet(
        setName: "History Time Travelers",
        subject: .history,
        difficulty: .normal,
        questions: [
            Question(
                questionText: "Which ancient people built the pyramids at Giza?",
                answerOptions: ["A. Egyptians", "B. Vikings", "C. Romans", "D. Aztecs"],
                correctAnswer: "A. Egyptians",
                explanation: "The ancient Egyptians built the pyramids at Giza.",
                subject: .history
            ),
            Question(
                questionText: "What do we call a person who studies the past?",
                answerOptions: ["A. Scientist", "B. Historian", "C. Pilot", "D. Artist"],
                correctAnswer: "B. Historian",
                explanation: "A historian researches and explains events from the past.",
                subject: .history
            ),
            Question(
                questionText: "Which invention helps people print many copies of a book?",
                answerOptions: ["A. Compass", "B. Printing press", "C. Telescope", "D. Telephone"],
                correctAnswer: "B. Printing press",
                explanation: "The printing press made it faster to produce books.",
                subject: .history
            ),
            Question(
                questionText: "What is a timeline used to show?",
                answerOptions: ["A. Events in order", "B. Weather each day", "C. A map's colors", "D. Animal sizes"],
                correctAnswer: "A. Events in order",
                explanation: "A timeline puts events in the order they happened.",
                subject: .history
            ),
            Question(
                questionText: "Which object can give us information about the past?",
                answerOptions: ["A. Artifact", "B. Rainbow", "C. Shadow", "D. Snowflake"],
                correctAnswer: "A. Artifact",
                explanation: "An artifact is an object made or used by people in the past.",
                subject: .history
            ),
            Question(
                questionText: "What was a castle mainly built to provide?",
                answerOptions: ["A. Protection", "B. A swimming pool", "C. A library card", "D. A garden tool"],
                correctAnswer: "A. Protection",
                explanation: "Castles were often built to protect people from attacks.",
                subject: .history
            ),
            Question(
                questionText: "Which transportation was used before cars and airplanes?",
                answerOptions: ["A. Horse-drawn wagon", "B. Space shuttle", "C. Electric scooter", "D. Subway train"],
                correctAnswer: "A. Horse-drawn wagon",
                explanation: "People traveled in horse-drawn wagons long before modern vehicles.",
                subject: .history
            ),
            Question(
                questionText: "What is a primary source?",
                answerOptions: ["A. Evidence from the time", "B. A modern guess", "C. A fictional story", "D. A math problem"],
                correctAnswer: "A. Evidence from the time",
                explanation: "A primary source comes directly from the time being studied.",
                subject: .history
            ),
            Question(
                questionText: "Why did early people make maps?",
                answerOptions: ["A. To show places", "B. To cook food", "C. To measure sound", "D. To grow plants"],
                correctAnswer: "A. To show places",
                explanation: "Maps help people understand where places are located.",
                subject: .history
            ),
            Question(
                questionText: "What does a museum usually preserve?",
                answerOptions: ["A. Historical objects", "B. Fresh lunches", "C. New shoes", "D. Clouds"],
                correctAnswer: "A. Historical objects",
                explanation: "Museums protect and display objects that teach us about the past.",
                subject: .history
            )
        ]
    )

    private static let frenchSampleSet = QuestionSet(
        setName: "French Friends",
        subject: .french,
        difficulty: .easy,
        questions: [
            Question(
                questionText: "What does 'bonjour' mean?",
                answerOptions: ["A. Goodbye", "B. Hello", "C. Thank you", "D. Please"],
                correctAnswer: "B. Hello",
                explanation: "Bonjour is a friendly way to say hello in French.",
                subject: .french
            ),
            Question(
                questionText: "What is the French word for 'one'?",
                answerOptions: ["A. Deux", "B. Trois", "C. Un", "D. Quatre"],
                correctAnswer: "C. Un",
                explanation: "Un means one in French.",
                subject: .french
            ),
            Question(
                questionText: "What does 'merci' mean?",
                answerOptions: ["A. Thank you", "B. Good morning", "C. Friend", "D. Yes"],
                correctAnswer: "A. Thank you",
                explanation: "Merci is the French word for thank you.",
                subject: .french
            ),
            Question(
                questionText: "What is the French word for 'red'?",
                answerOptions: ["A. Bleu", "B. Vert", "C. Rouge", "D. Jaune"],
                correctAnswer: "C. Rouge",
                explanation: "Rouge means red in French.",
                subject: .french
            ),
            Question(
                questionText: "What does 'chat' mean in English?",
                answerOptions: ["A. Dog", "B. Cat", "C. Bird", "D. Fish"],
                correctAnswer: "B. Cat",
                explanation: "Chat means cat in French.",
                subject: .french
            ),
            Question(
                questionText: "What is the French word for 'school'?",
                answerOptions: ["A. Maison", "B. Livre", "C. École", "D. Jardin"],
                correctAnswer: "C. École",
                explanation: "École means school in French.",
                subject: .french
            ),
            Question(
                questionText: "What does 'au revoir' mean?",
                answerOptions: ["A. See you later", "B. Good night", "C. Welcome", "D. Excuse me"],
                correctAnswer: "A. See you later",
                explanation: "Au revoir is a way to say goodbye or see you later.",
                subject: .french
            ),
            Question(
                questionText: "What is the French word for 'blue'?",
                answerOptions: ["A. Blanc", "B. Bleu", "C. Noir", "D. Rose"],
                correctAnswer: "B. Bleu",
                explanation: "Bleu means blue in French.",
                subject: .french
            ),
            Question(
                questionText: "What does 'ami' mean?",
                answerOptions: ["A. Teacher", "B. Friend", "C. Student", "D. Brother"],
                correctAnswer: "B. Friend",
                explanation: "Ami means friend in French.",
                subject: .french
            ),
            Question(
                questionText: "What is the French word for 'two'?",
                answerOptions: ["A. Un", "B. Deux", "C. Cinq", "D. Dix"],
                correctAnswer: "B. Deux",
                explanation: "Deux means two in French.",
                subject: .french
            )
        ]
    )

    private static let mathematicsSecondSet = QuestionSet(
        setName: "Mathematics Set 2",
        subject: .mathematics,
        difficulty: .normal,
        questions: [
            Question(questionText: "What is 9 × 7?", answerOptions: ["A. 56", "B. 63", "C. 72", "D. 81"], correctAnswer: "B. 63", explanation: "Nine groups of seven make 63.", subject: .mathematics),
            Question(questionText: "What is 250 + 175?", answerOptions: ["A. 325", "B. 375", "C. 425", "D. 475"], correctAnswer: "C. 425", explanation: "250 plus 175 equals 425.", subject: .mathematics),
            Question(questionText: "What fraction is shown by 3 out of 8?", answerOptions: ["A. 3/8", "B. 8/3", "C. 3/5", "D. 5/8"], correctAnswer: "A. 3/8", explanation: "Three out of eight equal parts is 3/8.", subject: .mathematics),
            Question(questionText: "How many degrees are in a right angle?", answerOptions: ["A. 45", "B. 60", "C. 90", "D. 180"], correctAnswer: "C. 90", explanation: "A right angle measures 90 degrees.", subject: .mathematics),
            Question(questionText: "What is 144 ÷ 12?", answerOptions: ["A. 10", "B. 12", "C. 14", "D. 16"], correctAnswer: "B. 12", explanation: "Twelve groups of twelve make 144.", subject: .mathematics),
            Question(questionText: "Which number is a multiple of 5?", answerOptions: ["A. 32", "B. 43", "C. 55", "D. 67"], correctAnswer: "C. 55", explanation: "55 can be divided evenly by 5.", subject: .mathematics),
            Question(questionText: "What is 80% of 50?", answerOptions: ["A. 30", "B. 35", "C. 40", "D. 45"], correctAnswer: "C. 40", explanation: "80 percent of 50 is 40.", subject: .mathematics),
            Question(questionText: "A rectangle is 8 cm long and 3 cm wide. What is its area?", answerOptions: ["A. 11 cm²", "B. 22 cm²", "C. 24 cm²", "D. 30 cm²"], correctAnswer: "C. 24 cm²", explanation: "Area equals length times width: 8 × 3 = 24.", subject: .mathematics),
            Question(questionText: "What is the next number: 3, 6, 9, 12, ?", answerOptions: ["A. 13", "B. 14", "C. 15", "D. 16"], correctAnswer: "C. 15", explanation: "The pattern adds 3 each time.", subject: .mathematics),
            Question(questionText: "What is 1,000 − 426?", answerOptions: ["A. 574", "B. 624", "C. 676", "D. 684"], correctAnswer: "A. 574", explanation: "Subtracting 426 from 1,000 gives 574.", subject: .mathematics)
        ]
    )

    private static let scienceSecondSet = QuestionSet(
        setName: "Science Set 2",
        subject: .science,
        difficulty: .normal,
        questions: [
            Question(questionText: "Which organ pumps blood through the body?", answerOptions: ["A. Heart", "B. Brain", "C. Lung", "D. Kidney"], correctAnswer: "A. Heart", explanation: "The heart pumps blood through the circulatory system.", subject: .science),
            Question(questionText: "What is the process plants use to make food?", answerOptions: ["A. Digestion", "B. Evaporation", "C. Photosynthesis", "D. Respiration"], correctAnswer: "C. Photosynthesis", explanation: "Photosynthesis uses sunlight to make plant food.", subject: .science),
            Question(questionText: "Which planet is known as the Red Planet?", answerOptions: ["A. Venus", "B. Mars", "C. Jupiter", "D. Saturn"], correctAnswer: "B. Mars", explanation: "Mars appears red because of iron-rich dust.", subject: .science),
            Question(questionText: "Which instrument measures temperature?", answerOptions: ["A. Compass", "B. Thermometer", "C. Telescope", "D. Microscope"], correctAnswer: "B. Thermometer", explanation: "A thermometer measures how hot or cold something is.", subject: .science),
            Question(questionText: "What type of animal is a frog?", answerOptions: ["A. Amphibian", "B. Reptile", "C. Mammal", "D. Fish"], correctAnswer: "A. Amphibian", explanation: "Frogs are amphibians that begin life in water.", subject: .science),
            Question(questionText: "Which layer of Earth do we live on?", answerOptions: ["A. Core", "B. Mantle", "C. Crust", "D. Magma"], correctAnswer: "C. Crust", explanation: "People live on Earth's outer solid layer, the crust.", subject: .science),
            Question(questionText: "What happens to liquid water when it evaporates?", answerOptions: ["A. It becomes vapor", "B. It becomes ice", "C. It becomes rock", "D. It becomes sand"], correctAnswer: "A. It becomes vapor", explanation: "Evaporation changes liquid water into water vapor.", subject: .science),
            Question(questionText: "Which sense is used to detect smells?", answerOptions: ["A. Sight", "B. Taste", "C. Hearing", "D. Smell"], correctAnswer: "D. Smell", explanation: "The nose detects different smells.", subject: .science),
            Question(questionText: "What do caterpillars become?", answerOptions: ["A. Frogs", "B. Butterflies", "C. Fish", "D. Birds"], correctAnswer: "B. Butterflies", explanation: "A caterpillar transforms into a butterfly or moth.", subject: .science),
            Question(questionText: "Which resource is renewable?", answerOptions: ["A. Coal", "B. Oil", "C. Sunlight", "D. Natural gas"], correctAnswer: "C. Sunlight", explanation: "Sunlight is continuously renewed by the Sun.", subject: .science)
        ]
    )

    private static let historySecondSet = QuestionSet(
        setName: "History Set 2",
        subject: .history,
        difficulty: .normal,
        questions: [
            Question(questionText: "Who was the first U.S. president?", answerOptions: ["A. George Washington", "B. Abraham Lincoln", "C. Thomas Jefferson", "D. John Adams"], correctAnswer: "A. George Washington", explanation: "George Washington served as the first U.S. president.", subject: .history),
            Question(questionText: "Which civilization used hieroglyphics?", answerOptions: ["A. Ancient Egypt", "B. Ancient Greece", "C. Viking lands", "D. China"], correctAnswer: "A. Ancient Egypt", explanation: "Ancient Egyptians used hieroglyphics for writing.", subject: .history),
            Question(questionText: "What tool does an archaeologist use to find artifacts?", answerOptions: ["A. Excavation tools", "B. Telescope", "C. Microscope", "D. Compass only"], correctAnswer: "A. Excavation tools", explanation: "Archaeologists carefully excavate sites to find artifacts.", subject: .history),
            Question(questionText: "The Renaissance began in which country?", answerOptions: ["A. Italy", "B. Australia", "C. Canada", "D. Japan"], correctAnswer: "A. Italy", explanation: "The Renaissance began in Italian city-states.", subject: .history),
            Question(questionText: "Which invention helped people print books faster?", answerOptions: ["A. Printing press", "B. Compass", "C. Steam engine", "D. Telescope"], correctAnswer: "A. Printing press", explanation: "The printing press made books easier and faster to produce.", subject: .history),
            Question(questionText: "What was the main purpose of ancient castles?", answerOptions: ["A. Defense", "B. Farming", "C. Painting", "D. Swimming"], correctAnswer: "A. Defense", explanation: "Castles protected people and territory.", subject: .history),
            Question(questionText: "Which civilization built Machu Picchu?", answerOptions: ["A. Inca", "B. Roman", "C. Persian", "D. Egyptian"], correctAnswer: "A. Inca", explanation: "The Inca civilization built Machu Picchu.", subject: .history),
            Question(questionText: "What system uses kings or queens as rulers?", answerOptions: ["A. Monarchy", "B. Democracy", "C. Republic", "D. Federation"], correctAnswer: "A. Monarchy", explanation: "A monarchy is ruled by a king or queen.", subject: .history),
            Question(questionText: "Why is the Rosetta Stone important?", answerOptions: ["A. It helped decode Egyptian writing", "B. It is a map", "C. It is a weapon", "D. It is a modern book"], correctAnswer: "A. It helped decode Egyptian writing", explanation: "The Rosetta Stone helped scholars understand hieroglyphics.", subject: .history),
            Question(questionText: "Which people lived in longhouses in parts of North America?", answerOptions: ["A. Haudenosaunee", "B. Vikings", "C. Romans", "D. Egyptians"], correctAnswer: "A. Haudenosaunee", explanation: "The Haudenosaunee built and lived in longhouses.", subject: .history)
        ]
    )

    private static let frenchSecondSet = QuestionSet(
        setName: "French Set 2",
        subject: .french,
        difficulty: .normal,
        questions: [
            Question(questionText: "What does 'bonsoir' mean?", answerOptions: ["A. Good evening", "B. Good morning", "C. Good night", "D. See you soon"], correctAnswer: "A. Good evening", explanation: "Bonsoir means good evening.", subject: .french),
            Question(questionText: "What is the French word for 'girl'?", answerOptions: ["A. Garçon", "B. Fille", "C. Homme", "D. Femme"], correctAnswer: "B. Fille", explanation: "Fille means girl.", subject: .french),
            Question(questionText: "What does 'livre' mean?", answerOptions: ["A. Apple", "B. Car", "C. Book", "D. Chair"], correctAnswer: "C. Book", explanation: "Livre means book.", subject: .french),
            Question(questionText: "What is 'five' in French?", answerOptions: ["A. Quatre", "B. Cinq", "C. Six", "D. Sept"], correctAnswer: "B. Cinq", explanation: "Cinq means five.", subject: .french),
            Question(questionText: "What does 'porte' mean?", answerOptions: ["A. Door", "B. Window", "C. Table", "D. Floor"], correctAnswer: "A. Door", explanation: "Porte means door.", subject: .french),
            Question(questionText: "What is the French word for 'white'?", answerOptions: ["A. Noir", "B. Blanc", "C. Gris", "D. Orange"], correctAnswer: "B. Blanc", explanation: "Blanc means white.", subject: .french),
            Question(questionText: "What does 'chien' mean?", answerOptions: ["A. Dog", "B. Cat", "C. Horse", "D. Rabbit"], correctAnswer: "A. Dog", explanation: "Chien means dog.", subject: .french),
            Question(questionText: "What is 'water' in French?", answerOptions: ["A. Eau", "B. Pain", "C. Fromage", "D. Lait"], correctAnswer: "A. Eau", explanation: "Eau means water.", subject: .french),
            Question(questionText: "What does 'petit' mean?", answerOptions: ["A. Big", "B. Small", "C. Fast", "D. Slow"], correctAnswer: "B. Small", explanation: "Petit means small.", subject: .french),
            Question(questionText: "What is 'goodbye' in French?", answerOptions: ["A. Salut", "B. Bonjour", "C. Merci", "D. S'il vous plaît"], correctAnswer: "A. Salut", explanation: "Salut can mean hello or goodbye informally.", subject: .french)
        ]
    )
}
