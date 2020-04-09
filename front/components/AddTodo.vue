<template>

  <v-form>
    <v-container>
      <v-row>
        <v-col cols="2" xs="6" sm="6" md="1" lg="1">
          <v-select label="TP" v-model="number" :items="items">test</v-select>
        </v-col>
        <v-col cols="10" xs="6" sm="6" md="4" lg="4">
          <v-text-field v-model="title" :counter="20" label="todo" required></v-text-field>
        </v-col>
      </v-row>
          <v-btn class="bo" @click="handleSubmit">DETERMINATION</v-btn>
    </v-container>
  </v-form>

</template>
<script>
const maxNumber = 11;
const numberRange = [...Array(maxNumber).keys()]

export default {
  data() {
    return {
      title: "",
      items: numberRange,
      number: '',
    };
  },
  methods: {
    handleSubmit() {
      const todo = {
        title: this.title,
        user_id: this.$store.state.currentUser.id,
        point: this.number
      };
      this.$emit("submit", todo);
      this.title = "";
      this.number = "";
    }
  }
};
</script>

<style>


</style>
