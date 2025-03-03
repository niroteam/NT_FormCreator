import React, { useState, useCallback } from "react";
import { useNuiEvent } from "@/hooks/useNuiEvent";
import { fetchNui } from "@/lib/fetchNui";
import { Button } from "@/components/ui/button";
import Question from "./components/question";
import {
  Card,
  CardContent,
  CardFooter,
  CardHeader,
  CardTitle,
} from "@/components/ui/card";

type QuizType = {
  id: number | string;
  title: string;
  description: string;
  questions: {
    id: number;
    question: string;
    answers: {
      answer: string;
      isCorrect: boolean;
    }[];
  }[];
  prize?: string;
  amount?: number;
  successPercent?: number;
};

const App: React.FC = () => {
  const [data, setData] = useState<QuizType | null>(null);
  const [currentPage, setCurrentPage] = useState(0);
  const [answers, setAnswers] = useState<Record<number, string>>({});
  const [isVisible, setIsVisible] = useState(false);
  const [isSubmitDisabled, setIsSubmitDisabled] = useState(false);
  const questionsPerPage = 4;

  const totalPages = Math.ceil(
    (data?.questions?.length ?? 0) / questionsPerPage + 1
  );

  useNuiEvent("startQustionare", (eventObj: { data: any; type: string }) => {
    if (!eventObj?.data?.questions) return;

    const receivedData: QuizType = {
      ...eventObj.data,
      questions: eventObj.data.questions.map(
        (
          question: {
            question: string;
            answers: { answer: string; isCorrect: boolean }[];
          },
          index: number
        ) => ({
          id: index + 1,
          question: question.question,
          answers: question.answers.map(answer => ({
            answer: answer.answer,
            isCorrect: answer.isCorrect,
          })),
        })
      ),
    };

    setData(receivedData);
    setIsVisible(true);
  });

  useNuiEvent("hideMessage", () => {
    setIsVisible(false);
  });

  const handleAnswer = useCallback((questionId: number, answer: string) => {
    setAnswers(prev => ({ ...prev, [questionId]: answer }));
  }, []);

  const handleNext = useCallback(() => {
    setCurrentPage(prev => Math.min(prev + 1, totalPages - 1));
  }, [totalPages]);

  const handleClose = useCallback(async () => {
    await fetchNui("hideMessage");
    setIsVisible(false);
    setCurrentPage(0);
    setAnswers({});
  }, []);

  const handleSubmit = useCallback(async () => {
    const unansweredQuestions = data?.questions.some(
      question => !answers[question.id]
    );

    if (unansweredQuestions) {
      alert("Please answer all questions before submitting.");
      return;
    }
    setIsVisible(false);
    setCurrentPage(0);
    setAnswers({});
    setData(null);
    try {
      await fetchNui("quizEnd", { answers: answers, id: data?.id });
    } catch (error) {
      console.error("Failed to submit quiz answers", error);
    }
  }, [answers, data]);

  const startIndex = (currentPage - 1) * questionsPerPage;
  const endIndex = startIndex + questionsPerPage;
  const currentQuestions =
    currentPage > 0 ? data?.questions.slice(startIndex, endIndex) || [] : [];
  const isLastPage = currentPage === totalPages - 1;
  if (!isVisible) return null;

  return (
    <div className="flex items-center justify-center min-h-screen">
      <Card className="w-full max-w-xl p-4">
        <CardHeader>
          <CardTitle className="text-center">
            {data?.title || "Questionnaire"}
          </CardTitle>
        </CardHeader>
        <CardContent className="space-y-4">
          {currentPage === 0 && (
            <div className="text-sm text-gray-500">{data?.description}</div>
          )}
          {currentPage > 0 &&
            currentQuestions.map(question => (
              <Question
                key={question.id}
                question={question}
                selectedAnswer={answers[question.id]}
                onAnswer={handleAnswer}
              />
            ))}
        </CardContent>
        <CardFooter className="flex justify-between items-center mt-4">
          <div className="text-sm text-gray-500">
            Page {currentPage + 1} of {totalPages}
          </div>
          <div className="text-xs text-gray-400">
            &copy; 2025-2026 NT_Scripts. All rights reserved.
          </div>
          <div className="flex space-x-2">
            {currentPage > 1 && (
              <Button
                className="hover:bg-gray-700"
                onClick={() => setCurrentPage(prev => Math.max(prev - 1, 0))}
              >
                ˂
              </Button>
            )}
            <Button
              className="bg-red-700 hover:bg-red-600"
              onClick={handleClose}
            >
              x
            </Button>
            {currentPage === 0 ? (
              <Button className="hover:bg-gray-700" onClick={handleNext}>
                Next
              </Button>
            ) : isLastPage ? (
              <Button
                className="bg-green-700 hover:bg-green-600"
                onClick={handleSubmit}
              >
                Submit
              </Button>
            ) : (
              <Button className="hover:bg-gray-700" onClick={handleNext}>
                ˃
              </Button>
            )}
          </div>
        </CardFooter>
      </Card>
    </div>
  );
};

export default App;
