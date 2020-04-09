<template>
  <v-app class="app" dark>
    <Loading />
    <Success />
    <v-navigation-drawer v-model="drawer" :mini-variant="miniVariant" :clipped="clipped" fixed app>
      <v-list>
        <v-list-item v-for="(item, i) in items" :key="i" :to="item.to" router exact>
          <v-list-item-action>
            <v-icon>{{ item.icon }}</v-icon>
          </v-list-item-action>
          <v-list-item-content>
            <v-list-item-title v-text="item.title" />
          </v-list-item-content>
        </v-list-item>
      </v-list>
    </v-navigation-drawer>
    <v-app-bar :clipped-left="clipped" fixed app>
      <v-app-bar-nav-icon @click.stop="drawer = !drawer" />
      <v-toolbar-title class="pl-0">
        <router-link to="/" class="toolbar-title">
          <v-icon class="mb-2" size="38">mdi-skull-outline</v-icon><span class="title-first">D</span>TODO
        </router-link>
      </v-toolbar-title>
      <v-spacer />
    </v-app-bar>
    <v-content>
      <v-container>
        <nuxt />
      </v-container>
    </v-content>

    <v-footer :fixed="fixed" app>
      <span>DETERMINATION.</span>
    </v-footer>
  </v-app>
</template>

<script>
  import Loading from "@/components/Loading";
  import Success from "@/components/Success";


  export default {
    data() {
      return {
        clipped: false,
        drawer: false,
        fixed: false,
        miniVariant: false,
        right: true,
        rightDrawer: false,
        title: "DTODO"
      };
    },
    components: {
      Loading,
      Success
    },
    computed: {
      user() {
        return this.$store.state.currentUser;
      },
      items() {
        if (this.user) {
          return [
            {
              icon: "mdi-heart",
              title: "TODO",
              to: "/user"
            },
            {
              icon: "mdi-lock",
              title: "REWARD",
              to: "/reward"
            }
          ];
        } else {
          return [
            {
              icon: "mdi-skull-crossbones",
              title: "トップ",
              to: "/"
            },
            {
              icon: "mdi-key-variant",
              title: "ログイン",
              to: "/login"
            },
            {
              icon: "mdi-account-arrow-right",
              title: "新規登録",
              to: "/signup"
            }
          ];
        }
      }
    }
  }
</script>

<style lang="scss">
  $main-color: #fc7b03;

  .app {
    .toolbar-title {
      color: white;
      text-decoration: none;
      font-family: 'Comic Sans MS';
      font-size: 30px;
      font-weight: bold;

      .title-first {
        color: $main-color;
      }
    }

    .v-content__wrap {
      background-color: black !important;
    }
  }
</style>
