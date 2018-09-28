/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow
 */

import React, {Component} from 'react';
import {StyleSheet, Text, Button, View, NativeModules} from 'react-native';
const LocationUpdator = NativeModules.LocationUpdator;

export default class App extends Component {

  componentDidMount() {
    this.hello();
  }
  hello() {
    LocationUpdator.locationUpdate();
    LocationUpdator.addEvent('Birthday Party', '4 Privet Drive, Surrey');
  }
  render() {
    return (
      <View>
        <Button
        title="some"
        onPress={() => this.hello()}
        />
        <Text style={{textAlign: 'center', marginTop: 30, fontWeight: 'bold'}}> hello </Text>
      </View>
    );
  }
}