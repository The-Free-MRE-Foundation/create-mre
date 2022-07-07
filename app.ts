/*!
 * Copyright (c) The Free MRE Foundation. All rights reserved.
 * Licensed under the MIT License.
 */

import { Context, ParameterSet, User } from "@microsoft/mixed-reality-extension-sdk";

/**
 * The main class of this app. All the logic goes here.
 */
export default class App {
        constructor(private context: Context, params: ParameterSet) {
                this.context.onStarted(() => this.started());
                this.context.onUserJoined((u: User) => this.userjoined(u));
                this.context.onUserLeft((u: User) => this.userleft(u));
        }

        /**
         * Once the context is "started", initialize the app.
         */
        private async started() {
        }

        private async userjoined(user: User) {
        }

        private async userleft(user: User) {
        }
}
