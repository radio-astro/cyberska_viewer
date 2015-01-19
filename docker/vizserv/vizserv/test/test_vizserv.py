#!/usr/bin/env python
# -*- coding: utf-8 -*-

# Copyright 2013  University of Calgary
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

import os
import vizserv
import unittest
import tempfile

import vizserv

# Prep work for fake request context
def get_x509_client_env(x509_dn):
    my_environ = {
        #'SSL_CLIENT_S_DN': 'Set to X.509 DN of desired cert',
        'SSL_CLIENT_VERIFY': 'SUCCESS',
        'SSL_CLIENT_V_REMAIN': 1
    }
    my_environ['SSL_CLIENT_S_DN'] = x509_dn
    return my_environ

class VizServTestCase(unittest.TestCase):

    def setUp(self):
        self.app = vizserv.vizserv.test_client()
        vizserv.init_db()
        pass

    def tearDown(self):
        pass


    def test_base(self):
        """ Server shows basic signs of life """
        self.fail('Need to write test')


#     def test_create_session_bad_user(self):
#         """ Access denied error occurs when unauthorized credentials are presented. """
#         self.fail('Need to write test')
# 
#     def test_create_session_missing_params(self):
#         """ Error shows when missing params are presented for an authorized user. """
#         self.fail('Need to write test')
# 
#     def test_create_session_valid_and_get_details(self):
#         """ Get a redirect to a status page for the session upon valid creds and params. """
#         self.fail('Need to write test')
# 
#     def test_get_session_bad_user(self):
#         """ Ensure that unauthorized users are banned from the server. """
#         self.fail('Need to write test')
# 
#     def test_get_session_missing_param(self):
#         """ Error shows when missing a session token. """
#         self.fail('Need to write test')
# 
#     def test_get_session_invalid(self):
#         """ Ensure that if an invalid session token is passed that an appropriate error occurs. """
#         self.fail('Need to write test')
# 
#     def test_session_delete_bad_user(self):
#         """ Create a session.  Attempt to delete it with bad credentials."""
#         self.fail('Need to write test')
# 
#     def test_session_delete_missing_param(self):
#         """ Ensure that attempting to delete a session with no token reports an appropriate error. """
#         self.fail('Need to write test')
# 
#     def test_session_delete_non_existent(self):
#         """ Ensure that an attempt to delete an invalid session fails. """
#         self.fail('Need to write test')
# 
#     def test_session_delete_valid(self):
#         """ Ensure that an attempt to delete a session succeeds when valid creds and params are fed in and the session exists. """
#         self.fail('Need to write test')
# 
#     def test_session_expiry(self):
#         """ Ensure that expiry works.  Create a session with 0 lifetime.  Sleep 2 seconds and ensure that it's no longer there """
#         self.fail('Need to write test')


if __name__ == '__main__':
    unittest.main()
