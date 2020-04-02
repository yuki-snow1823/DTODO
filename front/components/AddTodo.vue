<template>

  <v-form>
    <v-container>
      <v-row>
        <v-col cols="12" md="4">
          <!-- ここまでvuetifyの力 -->
          <v-text-field v-model="title" :counter="10" label="todo" required></v-text-field>
        </v-col>
        <v-col cols="12" md="4">
          <v-btn @click="handleSubmit">作成</v-btn>
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
</style>
