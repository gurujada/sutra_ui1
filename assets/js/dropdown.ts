document.querySelectorAll(`[data-component="dropdown"]`).forEach(el => {
  el.addEventListener('toggle', async e => {
    const button = el.querySelector('button')
    const nav = el.querySelector('nav')

    if (!button || !nav) throw new Error('dropdown component must have a button and a nav')

    const isOpen = button.getAttribute('aria-expanded') === 'true'

    const toggleHidden = () => {
      button.setAttribute('aria-expanded', isOpen ? 'false' : 'true')

      if (nav.hasAttribute('hidden')) {
        nav.removeAttribute('hidden')
      } else {
        nav.setAttribute('hidden', '')
      }
    }

    const keyframes = [
      { opacity: 0, transform: 'scale(0.95)' },
      { opacity: 1, transform: 'scale(1)' }
    ]

    const animate = async (keyframes: Keyframe[], options: KeyframeAnimationOptions) => {
      const animation = nav.animate(keyframes, options)

      await animation.finished
      animation.commitStyles()
      animation.cancel()
    }

    if (!isOpen) {
      toggleHidden()

      await animate(
        keyframes,
        { duration: 100, easing: 'ease-out', fill: "forwards" }
      )
    } else {
      await animate(
        [...keyframes].reverse(),
        { duration: 75, easing: 'ease-out', fill: "forwards" }
      )

      toggleHidden()
    }
  })
})
