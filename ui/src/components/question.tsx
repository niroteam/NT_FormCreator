import { RadioGroup, RadioGroupItem } from "@/components/ui/radio-group";
import { Label } from "@/components/ui/label";

interface QuestionProps {
  question: {
    id: number;
    question: string;
    answers: { answer: string; isCorrect: boolean }[];
  };
  selectedAnswer: string | undefined;
  onAnswer: (questionId: number, answer: string) => void;
}

export default function Question({
  question,
  selectedAnswer,
  onAnswer,
}: QuestionProps) {
  return (
    <div className="mb-6">
      <h3 className="text-lg font-semibold mb-2">{question.question}</h3>
      <RadioGroup
        value={selectedAnswer || ""}
        onValueChange={(value: string) => onAnswer(question.id, value)}
        className="flex flex-col space-y-2"
      >
        {question.answers?.map((answer, index) => (
          <div
            key={`${question.id}-${index}`}
            className="flex items-center space-x-2"
          >
            <RadioGroupItem
              value={answer.answer}
              id={`q${question.id}-option${index}`}
            />
            <Label htmlFor={`q${question.id}-option${index}`}>
              {answer.answer}
            </Label>
          </div>
        ))}
      </RadioGroup>
    </div>
  );
}
