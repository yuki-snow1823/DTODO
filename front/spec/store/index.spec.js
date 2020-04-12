import Vuex from "vuex";
import store from "@/store";
import {
  createLocalVue
} from "@vue/test-utils";
import _ from 'lodash'
import axios from 'axios'

const localVue = createLocalVue()
localVue.use(Vuex)

describe('store', () => {
  let store;

  beforeEach(() => {
    store = new Vuex.Store({
      state: {
        count: 1
      },
    })
  })

  it("mutation.increment", () => {
    expect(store.state.count).toBe(1);
  })
})
