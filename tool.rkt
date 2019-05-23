#lang racket/unit

(require drracket/tool
         framework
         racket/class
         racket/gui
         racket/date)

(import drracket:tool^)
(export drracket:tool-exports^)
(date-display-format 'iso-8601)
(define outputfile (open-output-file "C:\\Users\\Peter\\output.txt" #:exists 'append))

(define logging-enabled #f)
(define key-logging-mixin
  (λ (cls)
    (class cls
      (super-new)
      (inherit get-text
               last-position)
      
      (define/augment (after-insert start len)
        (inner (void) after-insert start len)         
        (when logging-enabled (write (~a "1 ," (date->string (current-date) #t) ", " (get-text start (+ start len))", "start ", " len "; \n") outputfile))
          )

 (define/augment (on-delete start len)
        (inner (void) on-delete start len)
        (when logging-enabled (write (~a "2 ," (date->string (current-date) #t)", "(get-text start (+ start len))", "start ", " len "; \n") outputfile))

   ))))


(define key-logging-frame-mixin
  (λ (cls)
    (class cls
          (super-new)
      (inherit get-tab-filename
      			get-definitions-text
                get-definitions-canvas
)

(define/override (edit-menu:between-find-and-preferences edit-menu)
      (super edit-menu:between-find-and-preferences edit-menu)
      (new checkable-menu-item%
           [label "key logging enabled"]
           [parent edit-menu]
           [checked logging-enabled]
           [callback
            (λ (i e) (set! logging-enabled (not logging-enabled))
              (message-box "" (~a "Logging is " logging-enabled))
             (write (~a "4, " (date->string (current-date) #t)", "  (send (get-definitions-text) get-text 0 300)) outputfile)
            )]))
      (define/augment (on-close)
        (close-output-port outputfile)
        (inner (void) on-close)
        )
    )))


(define key-logging-interactions-mixin
  (λ (cls)
    (class cls
      (super-new)
      (inherit get-text)
       (define/augment (after-insert start len)
        (inner (void) after-insert start len)
        (when logging-enabled (write(~a "3, " (date->string (current-date) #t)", " (get-text start (+ start len))", " start ", " len) outputfile))
   ))))
      

(define (phase1) (void))
(define (phase2) (void))

(drracket:get/extend:extend-definitions-text key-logging-mixin)
(drracket:get/extend:extend-interactions-text key-logging-interactions-mixin)
(drracket:get/extend:extend-unit-frame key-logging-frame-mixin)


