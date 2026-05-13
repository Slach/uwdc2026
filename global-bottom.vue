<template>
  <footer v-if="$slidev.nav.currentPage > 0" class="slide-counter">
    {{ $slidev.nav.currentPage }}/{{ $slidev.nav.total }}
  </footer>
</template>

<style scoped>
.slide-counter {
  position: fixed;
  right: 1.5rem;
  bottom: 1rem;
  font-size: 0.75rem;
  color: rgba(100, 100, 100, 0.6);
  z-index: 100;
}
</style>
