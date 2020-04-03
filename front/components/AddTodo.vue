<template>

  <v-form>
    <v-container>
      <v-row>
        <v-col cols="12" xs="6" sm="6" md="4" lg="4">
          <!-- ここまでvuetifyの力 -->
          <v-text-field v-model="title" :counter="10" label="todo" required></v-text-field>
        </v-col>
        <v-col cols="12" xs="6" sm="6" md="4" lg="4">
          <v-btn class="bo" @click="handleSubmit">DETERMINATION</v-btn>
          <!-- v-on -->
        </v-col>
      </v-row>
    </v-container>
  </v-form>

</template>
<script>
export default {
  data() {
    return {
      title: ""
      // v-modelと紐づいているからここも書き変わる
    };
  },
  methods: {
    handleSubmit() {
      const todo = {
        title: this.title,
        user_id: this.$store.state.currentUser.id
      };
      this.$emit("submit", todo);
      this.title = "";
    }
  }
};
</script>

<style>
.col-md-4 > .bo {
  color: #fc7b03;
  padding: 10px 40px !important;
  border: 2px solid #fc7b03;
  background-color: black !important;
  margin: 0 auto !important;
}

.bo:hover{
  border: 2px solid yellow;
  color: yellow;
}
</style>
