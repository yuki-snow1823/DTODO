<template>
  <v-row class="user-status" id="v-step-2">
    <v-col cols="12" xs="5" sm="6" md="5" lg="5">
      <p>
        名前：{{ currentUser.user.name}}
        <v-icon class="mb-2" color="yellow" size="30" v-if="currentUser.user.level == 10">mdi-crown</v-icon>
      </p>
      <div class="user-point">
        <p class="user-task-point">
          <v-icon class="mb-1" size="30" color="yellow">mdi-alpha-p-circle</v-icon>
          {{ currentUser.user.point }}
        </p>
      </div>
    </v-col>
    <v-col cols="12" xs="5" sm="6" md="5" lg="5">
      <p class="user-level">レベル：{{ currentUser.user.level }}</p>
      <p v-if="currentUser.user.level !== 10">
        次のレベルまであと
        {{ currentUser.untilLevel ? currentUser.untilLevel : 50 }} EXP
      </p>
      <p v-else>最大レベルです！</p>
      <v-progress-linear :height="12" :rounded="true"
        :value="currentUser.untilPercentage ? currentUser.untilPercentage : 0" color="light-blue"></v-progress-linear>
    </v-col>
  </v-row>
</template>

<script>
  export default {
    data() {
      return {
        show1: false,
        show2: false,
        error: "",
        showContent: false
      };
    },
    fetch({
      store,
      redirect
    }) {
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
      currentUser() {
        return this.$store.state.currentUser;
      }
    }
  }
</script>

<style lang="scss">
  $pc: 1024px;
  $tab: 680px;
  $sp: 480px;

  @mixin pc {
    @media (max-width: ($pc)) {
      @content;
    }
  }

  @mixin tab {
    @media (max-width: ($tab)) {
      @content;
    }
  }

  @mixin sp {
    @media (max-width: ($sp)) {
      @content;
    }
  }

  .user-status {
    border: 2px white solid;
    margin: 0 auto;
    width: 66%;
    background-color: rgb(60, 60, 65);

    .coin-img {
      width: 20% !important;
      display: inline-block;
    }

    .user-point {
      .user-task-point {
        font-size: x-large;
        color: rgb(238, 238, 37);
        padding-left: 2%;
        padding-top: 8px;
        margin-bottom: 0px;
      }
    }
  }

  .user-status {
    @include pc {
      width: 100%;
    }

    @include tab {
      width: 100% !important;
    }

    @include sp {
      width: 100% !important;
    }
  }
</style>
