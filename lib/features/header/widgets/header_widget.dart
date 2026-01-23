class HeaderWidget extends StatefulWidget {
  const HeaderWidget({super.key});

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  bool solid = false;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (n) {
        setState(() => solid = n.metrics.pixels > 40);
        return true;
      },
      child: BlocBuilder<HeaderBloc, HeaderState>(
        builder: (context, state) {
          if (state.loading) {
            return const CircularProgressIndicator();
          }

          return PopupMenuButton<CityModel>(
            child: const Text(
              "Find Your Hotel ▾",
              style: TextStyle(fontSize: 18),
            ),
            itemBuilder: (_) {
              return state.cities.map((city) {
                return PopupMenuItem(
                  value: city,
                  child: Text(city.name),
                );
              }).toList();
            },
            onSelected: (city) {
              CityHotelsModal.open(
                context,
                cityName: city.name,
                hotels: city.hotels,
                onHotelTap: (hotel) {
                  Navigator.pushNamed(
                    context,
                    "/hotel/${hotel.slug}",
                  );
                },
              );
            },
          );
        },
      );
      ,
    );
  }
}
