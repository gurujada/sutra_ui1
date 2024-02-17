defmodule Offcanvas do
  use Phoenix.Component
  alias Phoenix.LiveView.JS

  def offcanvas(assigns) do
    ~H"""
    <%!-- <div id="hs-overlay-example" class="hs-overlay hs-overlay-open:translate-x-0 -translate-x-full fixed top-0 start-0 transition-all duration-300 transform h-full max-w-xs w-full z-[80] bg-red-500 border-e ark:bg-gray-800 ark:border-gray-700" tabindex="-1">
      <div class="flex justify-between items-center py-3 px-4 border-b ark:border-gray-700">
        <h3 class="font-bold text-gray-800 ark:text-white">
          Offcanvas title
        </h3>
        <button type="button" class="flex justify-center items-center w-7 h-7 text-sm font-semibold rounded-full border border-transparent text-gray-800 hover:bg-gray-100 disabled:opacity-50 disabled:pointer-events-none dark:text-white dark:hover:bg-gray-700 dark:focus:outline-none dark:focus:ring-1 dark:focus:ring-gray-600" data-hs-overlay="#hs-overlay-example">
          <span class="sr-only">Close modal</span>
          <svg class="flex-shrink-0 w-4 h-4" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M18 6 6 18"/><path d="m6 6 12 12"/></svg>
        </button>
      </div>
      <div class="p-4">
        <p class="text-gray-800 dark:text-gray-400">
          Some text as placeholder. In real life you can have the elements you have chosen. Like, text, images, lists, etc.
        </p>
      </div>
    </div> --%>

    <%!-- <div class="h-screen w-full bg-gray-100 z-0 opacity-70 fixed inset-0">
    </div> --%>
    <div class={"#{toggle(assigns)} h-screen bg-red-500 w-1/5 top-0 left-0 absolute z-50 start-0 transition-all duration-300 transform"}>
      <div class="h-1/2 bg-green-500">

      </div>
    </div>
    """
  end

  def toggle(assigns) do
    if (@show_cart) do
      "translate-x-0 -translate-x-full"
    else "hidden"
    end
  end

end
