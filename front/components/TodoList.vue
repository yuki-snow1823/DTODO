<template>
  <div>
    <v-card class="pb-5">
      <v-card-title>
        <h2 class="list-title">TODO LIST</h2>
        <v-spacer></v-spacer>
      </v-card-title>
      <draggable class="pl-0" v-model="todos" :options="{ animation: 200, delay: 50 }" @end="atEnd" element="ul">
        <li class="todo-list" v-for="todo in todos" :key="todo.point">
          <v-hover v-slot:default="{ hover }">
            <v-icon @click="completeItem(todo)" big color="red" v-text="hover ? 'mdi-heart' : 'mdi-heart-outline'">
            </v-icon>
          </v-hover>
          <v-icon @click="editItem(todo)" big>mdi-pencil-plus</v-icon>
          <v-icon midium @click="deleteItem(todo)">delete</v-icon>
          <span class="todo-point">{{ todo.point }}</span>
          {{ todo.title }}
        </li>
      </draggable>
    </v-card>

    <v-dialog class="edit-dialog" v-model="dialog" max-width="60%">
      <v-card>
        <v-card-title>
          <h2 class="list-title">TODO編集</h2>
        </v-card-title>
        <v-card-text>タイトル</v-card-text>
        <v-text-field v-model="dialogText.title"></v-text-field>
        <v-btn @click="updateItem()">update</v-btn>
      </v-card>
    </v-dialog>

    <v-snackbar v-model="snack" :timeout="3000" :color="snackColor">
      {{ snackText }}
      <v-btn text @click="snack = false">Close</v-btn>
    </v-snackbar>

  </div>

</template>

<script>
  const maxNumber = 11;
  const numberRange = [...Array(maxNumber).keys()]
  import axios from "@/plugins/axios";
  export default {
    props: ["todos"],
    data() {
      return {
        singleSelect: true,
        selected: [],
        search: "",
        editOn: true,
        items: numberRange,
        snack: false,
        snackColor: "",
        snackText: "",
        dialogText: "",
        dialog: false
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
          const updateUser = {
            ...this.user,
            todos
          };
          this.$store.commit("setUser", updateUser);
          this.snack = true;
          this.snackColor = "warning";
          this.snackText = "Data deleted";
        }
      },
      async completeItem(item) {
        const res = confirm("本当に達成しますか？");
        if (res) {
          const getUser = await axios.get(`/v1/todos/${item.id}`, {
            params: {
              point: item.point
            }
          });
          console.log(getUser.data.user.point);
          const todos = this.user.todos.filter(todo => {
            return todo.id !== item.id;
          });
          this.user.level = getUser.data.user.level;
          this.user.point = getUser.data.user.point;
          this.user.experience_point = getUser.data.user.experience_point;
          const updateUser = {
            ...this.user,
            todos
          };
          this.$store.commit("setUser", updateUser);
          this.snack = true;
          this.snackColor = "success";
          this.snackText = "Data saved";
        }
      },
      async editItem(todo) {
        console.log(todo);
        this.dialog = true;

        this.dialogText = todo;

        // console.log(this.dialogText);
      },
      // async updateTitle(id, value) {
      //   await axios.patch(`/v1/todos/${id}`, {
      //     todo: {
      //       title: value
      //     }
      //   });
      // },
      // async updatePoint(id, value) {
      //   let result =
      //     await axios.patch(`/v1/todos/${id}`, {
      //       todo: {
      //         point: value
      //       }
      //     });
      // },
      async atEnd() {
        let result =
          await axios.patch(`v1/todos`, {
            todo: this.todos
          });
        const updateUser = {
          ...this.user,
          todos: this.todos
        };
        this.$store.commit("setUser", updateUser);
      },
      save() {
        this.snack = true;
        this.snackColor = "success";
        this.snackText = "Data saved";
      },
      cancel() {
        this.snack = true;
        this.snackColor = "error";
        this.snackText = "Canceled";
      },
      open() {
        this.snack = true;
        this.snackColor = "info";
        this.snackText = "Dialog opened";
      },
      close() {
        console.log("Dialog closed");
      }
    },
    watch: {}
  };
</script>

<style lang="scss">
  .v-icon {
    display: flex;
    justify-content: center;
  }

  .edit-window {
    z-index: 1;
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 30, 0.5);
    display: flex;
    align-items: center;
    justify-content: center;
  }

  .todo-list {
    // display: inline-block;
    list-style: none;
    color: black;
    margin: 10px;
    padding: 10px;
    border: 1px solid #7f7f7f;
    border-radius: 6px;
    background-color: #aab1b9;

    .todo-list-btn {
      background-color: rgb(206, 204, 87) !important;
    }

    .todo-point {
      color: rgb(75, 75, 243);
      font-weight: bold;
    }
  }
</style>
