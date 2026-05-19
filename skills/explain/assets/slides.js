(() => {
	function collectSlides() {
		const root = document.querySelector("section.level1") || document.body;
		const slides = [];

		const title = document.createElement("section");
		title.className = "explain-slide explain-title-slide";

		for (const child of Array.from(root.childNodes)) {
			if (
				child.nodeType === Node.ELEMENT_NODE &&
				child.matches("section.level2")
			)
				break;
			if (child.nodeType === Node.ELEMENT_NODE && child.matches("hr")) continue;
			title.appendChild(child.cloneNode(true));
		}

		if (title.textContent.trim()) slides.push(title);

		for (const section of Array.from(
			root.querySelectorAll(":scope > section.level2"),
		)) {
			const slide = section.cloneNode(true);
			slide.classList.add("explain-slide");
			slide.querySelectorAll("hr").forEach((hr) => hr.remove());
			slides.push(slide);
		}

		return slides;
	}

	function clamp(value, min, max) {
		return Math.max(min, Math.min(max, value));
	}

	function initDeck() {
		const slides = collectSlides();
		if (slides.length === 0) return;

		document.body.replaceChildren();

		const deck = document.createElement("main");
		deck.className = "explain-deck";

		const progress = document.createElement("div");
		progress.className = "explain-progress";

		const counter = document.createElement("div");
		counter.className = "explain-counter";

		for (const slide of slides) deck.appendChild(slide);
		document.body.append(deck, progress, counter);

		let index = Number.parseInt(location.hash.replace("#", ""), 10) - 1;
		if (Number.isNaN(index)) index = 0;

		function show(next) {
			index = clamp(next, 0, slides.length - 1);
			slides.forEach((slide, slideIndex) => {
				slide.classList.toggle("is-active", slideIndex === index);
			});
			progress.style.setProperty(
				"--progress",
				`${((index + 1) / slides.length) * 100}%`,
			);
			counter.textContent = `${index + 1} / ${slides.length}`;
			history.replaceState(null, "", `#${index + 1}`);
		}

		document.addEventListener("keydown", (event) => {
			if (["ArrowRight", "PageDown", " "].includes(event.key)) {
				event.preventDefault();
				show(index + 1);
			} else if (["ArrowLeft", "PageUp", "Backspace"].includes(event.key)) {
				event.preventDefault();
				show(index - 1);
			} else if (event.key === "Home") {
				event.preventDefault();
				show(0);
			} else if (event.key === "End") {
				event.preventDefault();
				show(slides.length - 1);
			}
		});

		document.addEventListener("click", (event) => {
			if (event.target.closest("a")) return;
			if (event.clientX > window.innerWidth * 0.72) show(index + 1);
			if (event.clientX < window.innerWidth * 0.28) show(index - 1);
		});

		show(index);
	}

	if (document.readyState === "loading") {
		document.addEventListener("DOMContentLoaded", initDeck);
	} else {
		initDeck();
	}
})();
