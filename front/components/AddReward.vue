<template>

  <v-form>
    <v-container class="add-todo">
      <v-row>
        <v-col class="pr-0" cols="3" xs="6" sm="2" md="1" lg="1">
          <v-select label="TP" v-model="number" :items="items">test</v-select>
        </v-col>
        <v-col class="pl-0" cols="9" xs="5" sm="6" md="7" lg="7">
          <v-text-field v-model="title" :counter="20" label="reward" required></v-text-field>
        </v-col>
        <v-col class="px-0" cols="12" xs="6" sm="4" md="4" lg="4">
                   <v-hover v-slot:default="{ hover }">
            <v-btn class="todo-btn" @click="handleSubmit">
              <v-icon v-text="hover ? 'mdi-heart' : ''">
                </v-icon>
               CREATE
            </v-btn>
          </v-hover>
        </v-col>
      </v-row>
    </v-container>
  </v-form>

</template>
<script>
const maxNumber = 11;
const numberRange = [...Array(maxNumber).keys()]
export default {
  data() {
    return {
      title: "",
      items: numberRange,
      number: '',
    };
  },
  methods: {
    handleSubmit() {
      const reward = {
        title: this.title,
        user_id: this.$store.state.currentUser.user.id,
        point: this.number
      };
      this.$emit("submit", reward);
      this.title = "";
      this.number = "";
    }
    
  }
};
</script>

<style lang="scss">
  $main-color: #fc7b03;

  @mixin btn {
    background-color: black !important;
    border: 2px solid $main-color;
    color: $main-color;
    display: inline-block;
    font-weight: bold;
    margin: 15px;
    width: 90%;
  }

  .add-todo {
    border: 2px white solid;

    .todo-btn {
      @include btn;

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
