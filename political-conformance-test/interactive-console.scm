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

;; The following will work for questions with a maximum of 3 (at present).
;; This contains: 0 (Strongly disagree) 1 (Disagree) 2 (Agree) 3 (Strongly agree).
;; Questions without a maximum score of 3 cannot be asked interactively using this module.

(define-module (political-conformance-test interactive-console))
(use-modules (ice-9 readline)
             (political-conformance-test operations))

;;(format #t "~s ~s ~s " out-string (number->string (1+ iteration)) (car remaining-responses))
;;TODO: For some reason the above approach didn't work but I thought that was a more elegant approach. Investigate
(define (response-string maximum-score)
  (letrec ((loop (lambda (remaining-responses out-string iteration)
                   (if (null? remaining-responses)
                       out-string
                       (loop (cdr remaining-responses) (string-append out-string (number->string (1+ iteration)) ". " (car remaining-responses) " ") (1+ iteration))))))
    (loop (response-strings maximum-score) "" 0)))

(define (get-user-response max-response)
  (let* ((entered-response (readline "Your response: "))
         (response-num (string->number entered-response))) ;;Will be #f if entered-response is NaN
    (if (or
         (not response-num)
         (> response-num max-response)
         (< response-num 0))
        (begin
          (display (format #f "You must enter a number between 1 and ~s" (number->string max-response)))
          (newline)
          (get-user-response max-response))
        response-num)))

;; Question is a question pair
(define-public (ask-question question)
  "Asks a question interactively, and evaluates to the answer"
  (display (string-append
   "Question: "
   (car question)
   "\n"
   "Choose a response from the following: "
   (response-string (cdr question))
   "\n"))
  (1- (get-user-response (1+ (cdr question)))))

;; See operations for details on the format of scores
(define-public (ask-questions questions)
  "Asks a series of questions, and evaluates to the scores for those questions"
  (letrec ((loop (lambda (remaining-questions scores)
                (if (null? remaining-questions)
                    scores
                    (loop (cdr remaining-questions) (answer-next-question remaining-questions scores (ask-question (car remaining-questions))))))))
    (loop questions '())))
