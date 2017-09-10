I wanted to have something in the project that kind of went through the features & some of my decisions in case you needed it!

I used MVVM for the architecture of the app with an API Manager and a View Model to retrieve and present the data for the Table View using RxSwift streams. I know there is an example of an app using MVP on my Github, so I wanted to show I can use both architectures.

I chose RxSwift because I wanted more practice with it, and I know that this is one of the best ways to work in MVVM. I really enjoy using it because of it's ability to let the View easily talk to the View Model and update eachother with very little code. I also wanted to show you guys that I am always looking for ways to get better with iOS programming, and I'm not afraid to fail.

The transition animator was also really fun to make. I used a custom navigation controller transition, where I scaled a bubble from the thumbnail frame of the table view cell tapped to cover the screen. Then, I moved to the detail view controller, where I grabbed the same color, set it as the background, removed the bubble, and faded in the detail UI.

The title label changing colors was just something I threw in at the end, because I thought it was cool. I wanted to see if it would affect/block scrolling of the table view. It didn't but I through it on the GCD to do it async just in case.

MVVM made testing a lot smoother than the typical MVC pattern. I didn't have to use any view or view controller to test my data flow & callbacks.

p.s.
Thank you guys for giving me an open ended coding challenge. It was really fun to try to think of ways to be creative.