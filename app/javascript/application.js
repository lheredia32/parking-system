// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";

document.addEventListener("DOMContentLoaded", () => {
  const searchModal = document.getElementById("search-modal");
  const searchField = document.querySelector(
    '#search-modal input[type="text"]'
  );

  // Abrir el modal y enfocar el campo de búsqueda
  function toggleModal(modalId) {
    const modal = document.getElementById(modalId);
    if (modal.classList.contains("hidden")) {
      modal.classList.remove("hidden");
      searchField.focus();
    } else {
      modal.classList.add("hidden");
    }
  }

  document.addEventListener("turbo:submit-end", (event) => {
    if (event.target.id === "search-modal") {
      // Si necesitas cerrar el modal después de enviar
      toggleModal("search-modal");
    }
  });

  window.toggleModal = toggleModal; // Exportar la función para usarla en HTML
});

document.addEventListener("turbo:submit-end", function (event) {
  if (event.target.id === "vehicle-form") {
    event.target.reset();
  }
});
