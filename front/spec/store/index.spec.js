import Vuex from 'vuex'
import * as index from '@/store'
import {
  createLocalVue
} from '@vue/test-utils'
import _ from 'lodash'
import axios from 'axios'

const localVue = createLocalVue()
localVue.use(Vuex)
