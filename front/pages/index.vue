<template>
  <v-container>
    <!-- <div v-if="user">
    <p>{{user.name}}</p>
    <p>{{user.id}}</p>
    <AddTodo @submit="addTodo" />
    <TodoList :todos="user.todos" /> -->

    <h1 id="title" class="text-center">DTODO</h1>
    <v-row>
      <v-col cols="12" sm="12" md="6" lg="6">
        <h2 class="mb-3 text-center">タスク管理をゲームに！</h2>
        <h3>これは紹介文です。これは紹介文です。これは紹介文です。これは紹介文です。これは紹介文です。
          これは紹介文です。これは紹介文です。これは紹介文です。これは紹介文です。これは紹介文です。これは紹介</h3>
      </v-col>
      <v-col cols="12" sm="12" md="6" lg="6">
        <form>
          <h2 class="text-center">新規登録はコチラ</h2>
          <v-text-field v-model="name" :counter="10" label="Name" data-vv-name="name" required></v-text-field>
          <v-text-field v-model="email" :counter="20" label="Email" data-vv-name="email" required></v-text-field>
          <v-text-field v-model="password" label="password" data-vv-name="password" required
            :type="show1 ? 'text' : 'password'" :append-icon="show1 ? 'mdi-eye' : 'mdi-eye-off'"
            @click:append="show1 = !show1"></v-text-field>
          <v-text-field v-model="passwordConfirm" label="passwordConfirm" data-vv-name="passwordConfirm" required
            :type="show2 ? 'text' : 'password'" :append-icon="show2 ? 'mdi-eye' : 'mdi-eye-off'"
            @click:append="show2 = !show2"></v-text-field>
          <v-btn class="mr-4" @click="signup">submit</v-btn>
          <p v-if="error" class="errors">{{error}}</p>
        </form>
      </v-col>
    </v-row>

    <v-row class="introduction">
      <v-col cols="12" sm="12" md="4" lg="4">
        <v-img width="50%" height="50%"
          src="https://4.bp.blogspot.com/-PDD_C43ZQ9A/V5AXrn_GD6I/AAAAAAAA8Z4/0KzHBvARnV4itcdlfhCpbtPSTwHYqPzcgCLcB/s800/vr_game_pad.png">
        </v-img>
        <h3>特徴の１つめです</h3>
        <p>説明文です。説明文です。説明文です。説明文です。説明文です。説明文です。
          説明文です。説明文です。説明文です。説明文です。説明文です。説明文です。
        </p>
      </v-col>
      <v-col cols="12" sm="12" md="4" lg="4">
        <v-img width="50%" height="50%"
          src="https://4.bp.blogspot.com/-PDD_C43ZQ9A/V5AXrn_GD6I/AAAAAAAA8Z4/0KzHBvARnV4itcdlfhCpbtPSTwHYqPzcgCLcB/s800/vr_game_pad.png">
        </v-img>
        <h3>特徴の１つめです</h3>
        <p>説明文です。説明文です。説明文です。説明文です。説明文です。説明文です。
          説明文です。説明文です。説明文です。説明文です。説明文です。説明文です。
        </p>
      </v-col>
      <v-col cols="12" sm="12" md="4" lg="4">
        <v-img width="50%" height="50%"
          src="https://4.bp.blogspot.com/-PDD_C43ZQ9A/V5AXrn_GD6I/AAAAAAAA8Z4/0KzHBvARnV4itcdlfhCpbtPSTwHYqPzcgCLcB/s800/vr_game_pad.png">
        </v-img>

        <h3>特徴の１つめです</h3>
        <p>説明文です。説明文です。説明文です。説明文です。説明文です。説明文です。
          説明文です。説明文です。説明文です。説明文です。説明文です。説明文です。
        </p>
      </v-col>
    </v-row>

    <v-row>
<v-col cols="8" sm="8" md="8" lg="8" offset="2">
        <v-carousel>
        <v-carousel-item v-for="(item,i) in items" :key="i" :src="item.src" reverse-transition="fade-transition"
          transition="fade-transition"></v-carousel-item>
      </v-carousel>
</v-col>
    </v-row>

    <v-row>
      <v-col cols="12" sm="12" md="6" lg="6">新規登録（押したら画面上に）</v-col>
      <v-col cols="12" sm="12" md="6" lg="6">ログイン（押したらウィンドウ）</v-col>
    </v-row>


  </v-container>
</template>

<script>
  import AddTodo from "@/components/AddTodo";
  import TodoList from "@/components/TodoList";
  import axios from "@/plugins/axios";

  export default {
    fetch({
      store,
      redirect
    }) {
      store.watch(
        state => state.currentUser,
        (newUser, oldUser) => {
          if (!newUser) {
            return redirect("/login");
          }
        }
      );
    },
    // 多分ここ
    components: {
      AddTodo,
      TodoList
    },
    computed: {
      user() {
        return this.$store.state.currentUser;
      }
    },
    methods: {
      async addTodo(todo) {
        const {
          data
        } = await axios.post("/v1/todos", {
          todo
        });
        //追加
        this.$store.commit("setUser", {
          ...this.user,
          todos: [...this.user.todos, data]
          // 初期値ではなくpostできるように
        });
      }
    }
  };
</script>

<style>
  #title {
    display: inline-block;
    background-color: #fc7b03;
    text-align: center;
    margin: 0 auto;
  }
  .introduction {
    margin-top: 50px;
  }
  .introduction h3 {
    text-align: center;
    margin: 0 auto;
    color: aqua !important;
  }
  /* 指定がうまくいかない */
  .v-img {
    text-align: center;
  }
  .v-window__container {
    border: solid 5px white;
  }
</style>
