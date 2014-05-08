Sloth
=====

## Requirements Met

1. App Icon
2. 3 Letter Prefixes
3. Storyboard
4. Delegate or adapter pattern
5. Segue (in KSCHomeViewController.h to the incomplete KSCStatisticsViewController)
6.Used the following new elements
  a) Facebook Graph / Login
  b) Parse 
  c) Twilio API
  d) Core Location
  e) Map Kit
7. Disclosure of what doesn't work: Almost everything works correctly. Unfortunately I think I selected a project that could not be completed in the allotted time without sacrificing performance on other finals. I had to spend a significant amount of time learning how to use Parse, Facebook Graph, and the Twilio API. The only thing that does not work correctly is the StatisticsView which is still in development. I did not want to scrape it entirely since I plan to continue working on the application after this submission. To make this view work properly I will need to embed the KSCHomeViewController inside a NavigationController. I did not want to do this for the submission since it will disrupt the Facebook log in process. Lastly, I did not implement Parse error catching entirely because I did not want to get too deep into threading. Therefore, if there is no internet connection, the app does not function well since it will take extra time to make Parse requests. 


## Unfulfilled features 

(mentioned in proposal but could not be satisfied in the given time)

1. Facebook Photo punishment
2. Backend scripts that execute consequences (currently it is done using a timer on the application itself)
3. Cancel button



