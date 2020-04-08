<template>
  <div>
    <v-card>
      <v-card-title>
        <h2>TODO</h2>
        <v-spacer></v-spacer>
        <!-- <v-text-field v-model="search" append-icon="search" label="Search" single-line hide-details></v-text-field> -->
      </v-card-title>
      <v-data-table :headers="headers" :items="todos" :search="search">

        <template v-slot:item.point="props">
          <v-edit-dialog @save="save" @cancel="cancel" @open="open" @close="close"
            :return-value="props.item.point">
            {{ props.item.point }}
            <template v-slot:input>
              <v-select @change="updatePoint(props.item.id, props.item.point)" v-model="props.item.point" :items="items"
                single-line :value="props.item.point"></v-select>
            </template>
          </v-edit-dialog>
        </template>

        <template v-slot:item.title="props">
          <v-edit-dialog @save="save" @cancel="cancel" @open="open" @close="close"
            :return-value.sync="props.item.title">
            {{ props.item.title }}
            <template v-slot:input>
              <v-text-field @change="updateTitle(props.item.id, props.item.title)" v-model="props.item.title"
                label="Edit" single-line counter></v-text-field>
            </template>
          </v-edit-dialog>
        </template>

        <template v-slot:item.action="{ item }">
          <v-icon midium @click="deleteItem(item)">delete</v-icon>
        </template>

        <template v-slot:item.complete="{ item }">
          <v-hover>
            <v-icon big color="red" @click="completeItem(item)">mdi-heart</v-icon>
          </v-hover>
        </template>

      </v-data-table>
    </v-card>
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
        headers: [{
            text: "check",
            width: "170",
            value: "complete"
          },
          {
            text: "TP",
            value: "point",
            width: "170"
          },
          {
            text: "content",
            align: "left",
            sortable: false,
            value: "title"
          },
          {
            text: "delete",
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
          this.snack = true;
          this.snackColor = "warning";
          this.snackText = "Data deleted";
        }
      },
      async completeItem(item) {
        const res = confirm("本当に達成しますか？");
        if (res) {
          await axios.get(`/v1/todos/${item.id}`, {
            params: {
              point: item.point
            }
          });
          const todos = this.user.todos.filter(todo => {
            return todo.id !== item.id;
          });
          this.user.point += item.point;
          this.user.experience_point += item.point;
          const newUser = {
            ...this.user,
            todos
          };
          this.$store.commit("setUser", newUser);
          this.snack = true;
          this.snackColor = "success";
          this.snackText = "Data saved";
        }
      },
      async editItem(item) {
        this.editOn = !this.editOn;
      },
      async updateTitle(id, value) {
        await axios.patch(`/v1/todos/${id}`, {
          todo: {
            title: value
          }
        });
      },
      async updatePoint(id, value) {
        let result = 
        await axios.patch(`/v1/todos/${id}`, {
          todo: {
            point: value
          }
        });
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
    watch: {
    }
  };
</script>

<style>
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
</style>
