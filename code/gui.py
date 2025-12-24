import streamlit as st
import pandas as pd
from sqlalchemy import create_engine, text
import pymysql  # required for "mysql+pymysql" in the connection string

# --------------------------------------------------------
# 1. CONNECT TO MYSQL DATABASE
# --------------------------------------------------------

password = "KeepUp1313$"  # <-- put your MySQL password
engine = create_engine(f"mysql+pymysql://root:{password}@localhost/IMDB")

# --------------------------------------------------------
# 2. STREAMLIT APP: INSERT NEW MOVIE
# --------------------------------------------------------

st.title("IMDB – Insert New Movie (GUI)")

st.write(
    """
    Use this graphical interface to insert a new movie into the *Movie* table,
    without writing SQL commands.
    """
)

with st.form("movie_form"):
    title = st.text_input("Title")

    year = st.number_input("Year", min_value=1900, max_value=2100, value=1999, step=1)

    genre = st.text_input("Genre", value="Drama")
    country = st.text_input("Country", value="USA")

    budget = st.number_input(
        "Budget (in dollars)",
        min_value=0,
        value=10_000_000,
        step=1_000_000
    )

    revenue = st.number_input(
        "Revenue (in dollars)",
        min_value=0,
        value=50_000_000,
        step=1_000_000
    )

    submitted = st.form_submit_button("Insert Movie")

if submitted:
    if title.strip() == "":
        st.error("Title cannot be empty.")
    else:
        try:
            # get next idMovie
            df_next = pd.read_sql(
                "SELECT COALESCE(MAX(idMovie), 0) + 1 AS next_id FROM Movie;",
                engine
            )
            new_id = int(df_next.loc[0, "next_id"])

            insert_sql = text("""
                INSERT INTO Movie (idMovie, Title, Year, Genre, Country, Budget, Revenue)
                VALUES (:id, :title, :year, :genre, :country, :budget, :revenue)
            """)

            with engine.begin() as conn:
                conn.execute(
                    insert_sql,
                    {
                        "id": new_id,
                        "title": title,
                        "year": int(year),
                        "genre": genre,
                        "country": country,
                        "budget": int(budget),
                        "revenue": int(revenue),
                    }
                )

            st.success(f"Movie inserted successfully with idMovie = {new_id}!")

        except Exception as e:
            st.error(f"Error while inserting the movie: {e}")

# --------------------------------------------------------
# 3. OPTIONAL: SHOW LAST 5 MOVIES (VIEW DATA)
# --------------------------------------------------------

st.subheader("Last 5 Movies in the Database")

try:
    movies = pd.read_sql(
        "SELECT idMovie, Title, Year, Genre, Country, Budget, Revenue "
        "FROM Movie ORDER BY idMovie DESC LIMIT 10;",
        engine
    )
    st.dataframe(movies)
except Exception as e:
    st.warning(f"Could not load movies: {e}")

# --------------------------------------------------------
# 4. DELETE A MOVIE BY ID
# --------------------------------------------------------

st.subheader("Delete a Movie from the Database")

movie_id_to_delete = st.number_input(
    "Enter idMovie to delete",
    min_value=1,
    step=1
)

if st.button("Delete Movie"):
    try:
        with engine.begin() as conn:
            conn.execute(
                text("DELETE FROM Movie WHERE idMovie = :id"),
                {"id": int(movie_id_to_delete)}
            )
        st.success(f"Movie with idMovie = {movie_id_to_delete} has been deleted.")
    except Exception as e:
        st.error(f"Error deleting movie: {e}")


