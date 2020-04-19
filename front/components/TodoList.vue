<template>
  <div>
    <v-card class="pb-5">
      <v-card-title>
        <h2 class="list-title">TODO LIST</h2>
        <v-spacer></v-spacer>
      </v-card-title>
      <draggable class="pl-0" v-model="todos" :options="{ animation: 200, delay: 50 }" @end="atEnd" element="ul">
        <li class="todo-list" v-for="todo in todos" :key="todo.sort">
          <span class="todo-point">{{ todo.point }}</span>
          <!-- <v-hover v-slot:default="{ hover }">
            <v-icon @click="completeItem(todo)" size="25px" color="blue" v-text="hover ? 'mdi-heart' : 'mdi-heart-outline'">
            </v-icon>
          </v-hover> -->
          <span class="todo-title">{{ todo.title }}</span>
          <div class="todo-list-icon">
            <v-icon @click="editItem(todo)" big>mdi-pencil-plus</v-icon>
            <v-icon midium @click="deleteItem(todo)">delete</v-icon>
          </div>
        </li>
      </draggable>
    </v-card>

    <v-dialog class="edit-dialog" v-model="dialog">
      <v-card>
        <v-card-title>
          <h2 class="list-title">TODO編集</h2>
        </v-card-title>
        <p>内容</p>
        <v-text-field class="dialog-title" v-model="dialogText.title" filled></v-text-field>
        <p>ポイント</p>
        <v-select class="dialog-point" single-line :items="items" v-model="dialogText.point" :value="dialogText.point"
          filled></v-select>
        <v-btn class="update-btn" @click="updateItem(dialogText.id, dialogText.title, dialogText.point)">保存</v-btn>
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
          this.snackText = item.point + "タスクポイントを獲得した！";
        }
      },
      async editItem(todo) {
        console.log(todo);
        this.dialog = true;
        this.dialogText = todo;
      },
      async updateItem(id, title, point) {
        await axios.patch(`/v1/todos/${id}`, {
          todo: {
            title: title,
            point: point
          }
        });
        this.dialog = false;
      },
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
  $main-color: #fc7b03;
  $sub-color: #33dddd;
  $accent-color: #f0353f;

  @mixin btn {
    background-color: rgb(29, 29, 29) !important;
    border: 2px solid $main-color;
    color: $main-color !important;
    display: inline-block;
    margin: 0px 5% 15px;
    width: 70%;
    font-weight: bold;
  }

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
    display: flex;
    list-style: none;
    border-left: solid 8px $sub-color !important;
    border-bottom: solid 2px rgb(121, 117, 117) !important;
    color: rgb(22, 16, 32);
    margin: 10px;
    padding: 10px;
    border: 1px solid #7f7f7f;
    border-radius: 6px;
    background-color: #c2d9f5;
    cursor: grab;

    .todo-list-icon {
      margin-left: auto;
    }

    .todo-list-btn {
      background-color: rgb(206, 204, 87) !important;
    }

    .todo-title {
      padding-top: 2px;
      margin-left: 10px;
    }
    .todo-point {
      color: rgb(41, 79, 160);
      font-weight: bold;
      display: inline-block;
      width: 25px;
      border-radius: 50%;
      text-align: center;
      background: rgb(250, 253, 71);
      color: $sub-color;
      box-shadow: inset 0 0 4px rgba(0, 0, 0, 0.08);
      border-bottom: solid 2px #b1a60c;
    }
  }

  .v-dialog {
    width: 70%;

    h2 {
      color: $sub-color;
    }

    p {
      margin-left: 5%;
    }

    .dialog-title {
      width: 90%;
      margin: 0 auto;
    }

    .dialog-point {
      width: 40%;
      margin-left: 5%;
    }

    .update-btn {
      @include btn
    }

  }
  
</style>
