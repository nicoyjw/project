/*globals $ window document clearInterval setInterval setTimeout objMLB currentItem */
$(function () {
	var s = null,
	myTimer = null,
	// primary namespace begins here
	MLBContentslider = {
		// below are the variables being used in the slider
		settings : {
			// below is the width of the slider, used when calculating the slide distance
			sliderWidth: $("#photo").width(),
			// below is the speed of the animated slider in miliseconds
			speed: 500,
			// the speed below is slightly faster for the thumbs appearance
			tspeed: 350,
			// below is the time between each slide for the auto-sliding mechanism
			intervalPause: 5000,
			// the variables below are just caching stuff that's reused
			photoList: $("#photo ul"),
			links: $("#thumbs a, #navigation ul a"),
			navLinks: $("#navigation ul a"),
			spans: "#thumbs ul li a span",
			thumbLinks: $("#thumbs a"),
			spanHTML: "<span></span>",
			hoverHTML: "<span class='hoverlight'></span>",
			hlClass: "highlight",
			hlLinks: "#thumbs a.highlight",
			hvLinks: "#thumbs a span.hoverlight",
			hoverBox: $("#hover-box"),
			prevNext: $(".prev-next"),
			playPause: $("#play-pause"),
			thumbs: $("#thumbs"),
			mainLink: $("#title>a"),
			pnItem: 0,
			// below are just initial values for later-used stuff
			marginSetting: null,
			clickedURL: null,
			clickedHash: null,
			navURL: null,
			navHash: null,
			thumbsURL: null,
			thumbsHash: null,
			mousedURL: null,
			mousedHash: null,
			currentView: null,
			activeItem: null
		},

		// function to populate the data for the clicked item; data comes from file: "js/data.js"
		init: function (currentItem, objMLB) {
			s = this.settings;
			$("#thumbs p").html(objMLB.headlineText[currentItem - 1]);
			$("#long-desc").html(objMLB.descText[currentItem - 1]);
			$("#title>a").html(objMLB.headlineText[currentItem - 1]);
			$("#title>a")[0].href = objMLB.extURL[currentItem - 1];
			$("#small-caption").html(objMLB.smallCaption[currentItem - 1]);
			
		},

		// the function below shows the thumbs for a quick second, to show the user the full interface
		showThumbs: function () {
			s.thumbs.css("display", "block");
			s.thumbs.animate({
				opacity: 1,
				bottom: "24px"
			}, s.speed, function () {
					setTimeout(function () {
						s.thumbs.animate({
							opacity: 0,
							bottom: "-24px"
						}, s.speed, function () {
							s.thumbs.css("display", "none");
						});
					}, 1500);
				});

		},

		// this triggers click functionality for the thumbs and circle links
		doClick: function () {
			s = this.settings;
			// bind a click event to the thumbnail photos and navigation links
			$(s.links).bind("click", function () {
				clearInterval(myTimer);
				s.playPause.removeClass().addClass("play");
				$(s.spans).remove();
				// get the clicked item from the URL
				s.clickedURL = this.href.toString();
				s.clickedHash = s.clickedURL.split("#")[1];
				// a previously existing highlight is removed to prevent duplicates
				$(s.links).removeClass(s.hlClass);

				// loop through the navigation links to highlight the clicked one
				s.navLinks.each(function () {
					s.navURL = this.href.toString();
					s.navHash = s.navURL.split("#")[1];
					if (s.clickedHash === s.navHash) {
						$(this).addClass(s.hlClass);
						$(s.spanHTML).appendTo(s.hlLinks);
					}
				});

				// loop through all thumbnails, highlight the clicked one
				s.thumbLinks.each(function () {
					s.thumbsURL = this.href.toString();
					s.thumbsHash = s.thumbsURL.split("#")[1];
					if (s.clickedHash === s.thumbsHash) {
						$(this).addClass(s.hlClass);
						$(s.spanHTML).appendTo(s.hlLinks);
					}
				});

				// if any of items 2-6 are clicked, animate the margin accordingly
				if (s.clickedHash > 1) {
					s.marginSetting = s.sliderWidth * s.clickedHash - s.sliderWidth;
					s.photoList.animate({
						marginLeft: "-" + s.marginSetting + "px"
					}, s.speed, function () {
						  // optional callback after animation completes
					});

				// if item 1 is clicked, send the switcher back to the front (0 margin)
				} else {
					s.photoList.animate({
							marginLeft: "0px"
						}, s.speed, function () {
							// optional callback after animation completes
					});
				}
				MLBContentslider.init(s.clickedHash, objMLB);
				return false;
			});

		},
		
		// This triggers the hover funcionality for thumbs
		doHover: function () {
			s = this.settings;
			// create the hover effect on the thumbnails
			s.links.hover(function () {
				// remove highlight to prevent duplicates
				$(s.hvLinks).remove();
				$(s.spans).remove();
				$(s.hoverHTML).appendTo(s.hlLinks);

				s.mousedURL = this.href.toString();
				s.mousedHash = s.mousedURL.split("#")[1];
				$(s.hoverHTML).appendTo("#thumbs ul li:nth-child(" + s.mousedHash + ") a");
			}, function () {
					// callback executes after hover complete, so highlight is always ultimately removed
					$(s.hvLinks).remove();
					$(s.hoverHTML).appendTo(s.hlLinks);
				});

			// Fade in the thumbs only when the nav bar is hovered
			// If you want the thumbs always visible, comment out these 5 lines below, and show #thumbs in CSS
			s.hoverBox.hover(function () {
				s.thumbs.css("display", "block");
				s.thumbs.stop().animate({
					opacity: 1,
					bottom: "24px"
				}, s.tspeed);
			}, function () {
					// callback function after animation completes
					s.thumbs.stop().animate({
						opacity: 0,
						bottom: "0px"
					}, s.tspeed, function () { 
							s.thumbs.css("display", "none");
						});
				});
		},
	
		// prepare the previous/next buttons for the actions that result
		prepPreviousNext: function () {

			s.prevNext.bind("click", function () {
				clearInterval(myTimer);
				s.playPause.removeClass().addClass("play");
				s.activeItem = $("#thumbs ul li a.highlight")[0].href.split("#")[1];

				// make sure the value from the URL is a number, otherwise addition operator won't work
				s.activeItem = parseInt(s.activeItem, 10);

				// decide the prev/next item based on link ID and active item
				// this makes sure that "6" is the "previous" item in relation to "1",
				// and "1" is "next" in relation to "6"
				if ($(this).attr("id") === "prev") {
					if (s.activeItem === 1) {
						s.pnItem = 6;   
					} else {
						s.pnItem = s.activeItem - 1;												   
					}
				} else {
					if (s.activeItem === 6) {
						s.pnItem = 1;
					} else {
						s.pnItem = s.activeItem + 1;
					}
				}

				// remove highlight before adding the new one, to avoid duplicates

				$(s.spans).remove();
				s.links.removeClass(s.hlClass);

				MLBContentslider.doPreviousNext(s.activeItem, s.pnItem);
				return false;
			});
		},
		
		// below are the previous/next actions
		doPreviousNext: function (activeItem, pnItem) {
			s = this.settings;
			$(s.spanHTML).appendTo("#thumbs ul li:nth-child(" + s.pnItem + ") a");
			$("#thumbs ul li:nth-child(" + s.pnItem + ") a").addClass(s.hlClass);
			$("#navigation ul li:nth-child(" + s.pnItem + ") a").addClass(s.hlClass);
		
			// calculate the animated margins
			if (s.pnItem > 1) {
				s.marginSetting = s.sliderWidth * s.pnItem - s.sliderWidth;
				s.photoList.animate({
					marginLeft: "-" + s.marginSetting + "px"
				}, s.speed);
		
			} else {
				s.photoList.animate({
					marginLeft: "0px"
				}, s.speed);
			}
			this.init(s.pnItem, objMLB);
		},
		
		// Below are the auto-run actions
		// there's probably too much repeated here from other sections, but whatever
		doAutoRun: function () {
			s = this.settings;
			s.currentView = $(s.hlLinks)[0].href.split("#")[1];
			s.currentView = parseInt(s.currentView, 10);
			
			if (s.currentView === 6) {
				s.currentView = 1;
			} else {
				s.currentView += 1;	
			}

			s.thumbLinks.removeClass();
			$(s.spans).remove();
			s.navLinks.removeClass();
			
			$("#thumbs ul li:nth-child(" + s.currentView + ") a").addClass(s.hlClass);
			$("#navigation ul li:nth-child(" + s.currentView + ") a").addClass(s.hlClass);
			$(s.hoverHTML).appendTo("#thumbs ul li:nth-child(" + s.currentView + ") a");

			if (s.currentView > 1) {
				s.marginSetting = s.sliderWidth * s.currentView - s.sliderWidth;
				s.photoList.animate({
					marginLeft: "-" + s.marginSetting + "px"
				}, s.speed);
		
			} else {
				s.photoList.animate({
					marginLeft: "0px"
				}, s.speed);
			}
			this.init(s.currentView, objMLB);
		},
		
		// play and pause the auto-run feature
		doPlayPause: function () {
			s = this.settings;
			s.playPause.click(function () {
				if ($(this).hasClass("pause")) {
					$(this).removeClass().addClass("play");
					clearInterval(myTimer);
				} else {
					$(this).removeClass().addClass("play pause");
					clearInterval(myTimer);
					myTimer = setInterval(function () {
						MLBContentslider.doAutoRun();
					}, s.intervalPause);

				}
				return false;
			});
		}

	}; // primary MLBContentslider namespace ends here
	
	// these are the function calls to trigger all the functionality
	// I have no idea if there is a better way to do this
	MLBContentslider.init(currentItem, objMLB);
	MLBContentslider.showThumbs();
	MLBContentslider.doClick();
	MLBContentslider.doHover();
	MLBContentslider.prepPreviousNext();
	myTimer = setInterval(function () {
		MLBContentslider.doAutoRun();
	}, MLBContentslider.settings.intervalPause);
	MLBContentslider.doPlayPause();
});