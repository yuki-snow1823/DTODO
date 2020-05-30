<template>
  <v-snackbar v-model="snack" :timeout="3000" :color="snackColor">
    {{ snackText }}
    <v-btn text @click="snack = false">Close</v-btn>
  </v-snackbar>
</template>

<script>
  export default {
    data() {
      return {
        snack: false,
        snackColor: "",
        snackText: "",
      };
    },
  };
</script>

<style lang="scss">

</style>
