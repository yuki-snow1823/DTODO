<template>
  <v-container>
    <v-row>
      <v-col>
        <p>ここはショップです。</p>
        <ul>
          <li>すごいアイコン<v-btn>購入</v-btn></li>
          <li>普通のアイコン</li>
          <li>ダサいアイコン</li>
        </ul>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
export default {
  data() {
    return {
      experience_point: "",
      show1: false,
      show2: false,
      error: "",
      showContent: false
    };
  },
  fetch({ store, redirect }) {
    store.watch(
      state => state.currentUser,
      (newUser, oldUser) => {
        console.log(newUser, oldUser);
        if (!newUser) {
          return redirect("/");
        }
      }
    );
  },
  computed: {
    // currentUserと書くだけで表示してくれるメリットがある
    currentUser() {
      return this.$store.state.currentUser;
    }
  }
};
</script>
