;;; Political Conformance Test
;;; Copyright (C) 2022 James Crake-Merani
;;;
;;; This program is free software: you can redistribute it and/or modify
;;; it under the terms of the GNU General Public License as published by
;;; the Free Software Foundation, either version 3 of the License, or
;;; (at your option) any later version.
;;;
;;; This program is distributed in the hope that it will be useful,
;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;; GNU General Public License for more details.
;;;
;;; You should have received a copy of the GNU General Public License
;;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

(define-module (political-conformance-test operations))
(use-modules (ice-9 textual-ports))

(define-public (response-strings maximum-score)
  "Gives an appropriate list of response strings with a given maximum score"
  (cond ((= maximum-score 3) '("Strongly disagree" "Disagree" "Agree" "Strongly agree"))
        ((= maximum-score 1) '("No" "Yes"))
        (else #f)))

;; Scores is a list of pairs.
;; Each pair's car is the score attained, and the cdr is the maximum possible score for that question.
;; Score attained must be > 0, and <= maximum possible score.
(define-public (test-fraction scores)
  "Takes a list of scores, and then adds them up until we get total, and maximum score with which we output"
  (letrec ((loop (lambda (total-score total-max scores)
                (if (null? scores)
                    (/ total-score total-max)
                    (loop (+ total-score (caar scores)) (+ total-max (cdar scores)) (cdr scores)))))
        )
    (loop 0 0 scores)))

(define-public (as-percentage n)
  "Takes an exact fraction, and represents it as an inexact percentage"
  (round (* n 100.0)))

;; Questions are represented by a pair with the car being the question string (presented to the user) and the cdr being the maximum score
(define-public (answer-next-question questions scores answer)
  "Evaluates to a new scores which includes the answered question's score"
  (cons (cons answer (cdar questions)) scores))

;; Questions in text form are expected to have an even number of lines.
;; Each pair of lines should contain the question text followed by the maximum score.
(define-public (parse-questions text)
  "Takes a text-string of the questions in the expected format, and evaluate to a list of questions"
  (letrec ((loop (lambda (questions remaining-lines)
                (if (< (length remaining-lines) 2) ;;Prevents trailing newlines from being parsed
                    questions
                    (loop (cons (cons (car remaining-lines) (string->number (cadr remaining-lines))) questions) (cddr remaining-lines))))))
    (loop '() (string-split text #\newline))))

(define-public (load-questions path)
  "Load questions in from the given path"
  (let* ((port (open path O_RDONLY))
         (text (get-string-all port)))
    (close-port port)
    (parse-questions text)))
