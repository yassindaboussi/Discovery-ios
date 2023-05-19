import Foundation
import SwiftUI
import MapKit
import CoreLocation

struct MapDialog: View {
    var place: Place
    @Binding var isPresented: Bool
    @State private var region = MKCoordinateRegion()

    var body: some View {
        VStack {
            Spacer()

            Map(coordinateRegion: $region, annotationItems: [place]) { place in
                MapMarker(coordinate: region.center,tint: .red)
            }
            .frame(width: 400, height: 600)
            .onAppear {
                setRegion()
            }

            Spacer()

            HStack {
                Button("Cancel") {
                    isPresented = false
                }
                .padding()
                .foregroundColor(.white)
                .background(.red)
                .cornerRadius(10)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
    }

    private func setRegion() {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString( place.lieux) { placemarks, error in
            guard let placemark = placemarks?.first, let location = placemark.location else {
                return
            }
            region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        }
    }
}
