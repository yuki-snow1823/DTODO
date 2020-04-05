<template>
  <v-card>
    <v-card-title>
      <h2>TODO</h2>
      <v-spacer></v-spacer>
      <!-- <v-text-field v-model="search" append-icon="search" label="Search" single-line hide-details></v-text-field> -->
      <!-- 残してもいいかも -->
    </v-card-title>
    <v-data-table :headers="headers" :items="todos" :search="search">
      <!-- ここにアイテムの名前が表示される -->

      <template v-slot:item.action="{ item }">
        <v-icon midium @click="deleteItem(item)">delete</v-icon>
      </template>

      <template v-slot:item.complete="{ item }">
        <v-icon big @click="completeItem(item)">mdi-heart</v-icon>
        <!-- やったことを送信する -->
      </template>

      <template v-slot:item.edit="{ item }">
        <v-icon smaill @click="editItem(item)">create</v-icon>
        <!-- 編集ボタン -->
      </template>
    </v-data-table>
    
  </v-card>
</template>

<script>
import axios from "@/plugins/axios";
export default {
  props: ["todos"],
  data() {
    return {
      singleSelect: true,
      selected: [],
      search: "",
      headers: [
        { 
          text: "check", 
          width: '170',
          value: "complete"
        },
       { 
          text: "TP", 
          value: "point",
          width: '170' 
          // 幅の固定もできる
        },
        // これ押したらチェックするみたいな感じにしたい
        {
          text: "content",
          align: "left",
          sortable: false,
          value: "title"
        },
        // { text: "ユーザー名", value: "username" },
        { text: "edit", 
          value: "edit",  
          sortable: false },
        { text: "delete", 
          value: "action",  
          sortable: false 
        }
      ]
    };
  },
  computed: {
    user() {
      return this.$store.state.currentUser;
    }
  },
  methods: {
    async deleteItem(item) {
      const res = confirm("本当に削除しますか？");
      if (res) {
        await axios.delete(`/v1/todos/${item.id}`);
        const todos = this.user.todos.filter(todo => {
          return todo.id !== item.id;
        });
        const newUser = {
          ...this.user,
          todos
        };
        this.$store.commit("setUser", newUser);
      }
    },
    // 完了メソッド
    async completeItem(item) {
      const res = confirm("本当に達成しますか？");
      if (res) {
        await axios.get(`/v1/todos/${item.id}`,
          {
            params: {
            point: this.todos.point
          }});
        // ここにその持っているタスク分ユーザーにポイントを追加するメソッドを書く
        // this.user.point += this.todos.point;
        // 予想→うまく行かなかった
        const todos = this.todos.point;
        // 多分ここは何もしなくていいはず
        const newUser = {
          ...this.user,
          todos,
        };
        this.$store.commit("setUser", newUser);
      }
    } 
  }
};
</script>

<style>

.v-icon {
  display: flex;
  justify-content: center;
}
</style>
