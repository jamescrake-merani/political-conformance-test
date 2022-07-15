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

(use-modules (srfi srfi-64)
             (political-conformance-test operations))

(define example-parsable-questions "First example
1
Second Example
3")

(test-begin "pct-test")

;; This test ensures that questions can be parsed from test correctly
(let ((parsed-questions (parse-questions example-parsable-questions)))
  (test-equal parsed-questions '(("First example" . 1) ("Second example" . 3))))

(test-end "pct-test")
