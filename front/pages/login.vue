<template>
  <v-row>
    <v-col cols="12" md="4">
      <h2>Login</h2>
      <form>
        <v-text-field v-model="email" :counter="20" label="email" data-vv-name="email" required></v-text-field>
        <v-text-field v-model="password" label="password" data-vv-name="password" required
          :type="show1 ? 'text' : 'password'" :append-icon="show1 ? 'mdi-eye' : 'mdi-eye-off'"
          @click:append="show1 = !show1"></v-text-field>
        <v-btn class="mr-4 px-7" color="#f5851d" @click="login">LOCK!</v-btn>
        <v-icon color="red">mdi-heart</v-icon>
        <p v-if="error" class="errors">{{error}}</p>
      </form>
    </v-col>
  </v-row>
</template>
<script>
  import firebase from "@/plugins/firebase";
  export default {
    data() {
      return {
        email: "",
        password: "",
        show1: false,
        error: ""
      };
    },
    methods: {
      login() {
        this.$store.dispatch("login", {
          email: this.email,
          password: this.password
        });
        console.log("hoge");
      }
    }
  };
</script>
<style scoped>
  .errors {
    color: red;
    margin-top: 20px;
  }
</style>
