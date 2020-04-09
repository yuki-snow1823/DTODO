<template>
  <v-row class="login-wrapper">
    <v-col cols="12" md="4">
      <h2 class="login-title">Login</h2>
      <form>
        <v-text-field v-model="email" :counter="20" label="email" data-vv-name="email" required></v-text-field>
        <v-text-field v-model="password" label="password" data-vv-name="password" required
          :type="show1 ? 'text' : 'password'" :append-icon="show1 ? 'mdi-eye' : 'mdi-eye-off'"
          @click:append="show1 = !show1"></v-text-field>
        <v-hover v-slot:default="{ hover }">
          <v-btn class="bottom-btn" @click="login">
            <v-icon v-text="hover ? 'mdi-heart' : ''"></v-icon>DETERMINATION
          </v-btn>
        </v-hover>
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
<style lang="scss">
  $main-color: #fc7b03;
  $sub-color: #33dddd;

  @mixin index-bottom-btn {
    background-color: black !important;
    border: 2px solid $main-color;
    color: $main-color;
    display: inline-block;
    margin: 15px;
    width: 100%;
    font-weight: bold;
    margin-left: 0;
  }

  .login-wrapper {

    .errors {
      color: red;
      margin-top: 20px;
    }
    .login-title {
      color: $sub-color;
    }

    .bottom-btn {
      @include index-bottom-btn;

      &:hover {
        border: 2px solid yellow;
        color: yellow;
      }
    }
    .mdi-heart {
      color: red !important;
    }
  }
</style>
